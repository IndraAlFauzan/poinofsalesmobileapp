import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/request/payment_settle_request.dart';
import 'package:posmobile/data/model/response/payment_response.dart';
import 'package:posmobile/data/model/response/payment_single_response.dart';
import 'package:posmobile/data/repository/payment_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'payment_settlement_event.dart';
part 'payment_settlement_state.dart';
part 'payment_settlement_bloc.freezed.dart';

EventTransformer<E> _droppableThrottle<E>(Duration duration) {
  return (events, mapper) =>
      droppable<E>().call(events.throttle(duration), mapper);
}

class PaymentSettlementBloc
    extends Bloc<PaymentSettlementEvent, PaymentSettlementState> {
  final PaymentRepository _paymentRepo;

  PaymentSettlementBloc(this._paymentRepo) : super(const _Initial()) {
    on<_Started>(
      (event, emit) => add(const PaymentSettlementEvent.fetchPayments()),
    );

    on<_FetchPayments>(
      _onFetchPayments,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );

    on<_SettlePayment>(
      _onSettlePayment,
      transformer: _droppableThrottle(const Duration(milliseconds: 500)),
    );

    on<_PollPaymentStatus>(
      _onPollPaymentStatus,
      transformer: _droppableThrottle(const Duration(milliseconds: 500)),
    );

    on<_RetryPayment>(
      _onRetryPayment,
      transformer: _droppableThrottle(const Duration(milliseconds: 500)),
    );

    on<_CancelPayment>(
      _onCancelPayment,
      transformer: _droppableThrottle(const Duration(milliseconds: 500)),
    );

    on<_StopPolling>(_onStopPolling);
  }

  @override
  Future<void> close() {
    // No timer cleanup needed since we use self-triggering events
    return super.close();
  }

  Future<void> _onFetchPayments(
    _FetchPayments event,
    Emitter<PaymentSettlementState> emit,
  ) async {
    try {
      emit(const PaymentSettlementState.loading());
      final result = await _paymentRepo.fetchPayments();

      result.fold(
        (error) {
          emit(PaymentSettlementState.failure(error));
          log("Error fetching payments: $error");
        },

        (response) => emit(
          PaymentSettlementState.paymentsLoaded(payments: response.data),
        ),
      );
    } catch (e) {
      emit(PaymentSettlementState.failure("Error fetching payments: $e"));
    }
  }

  Future<void> _onSettlePayment(
    _SettlePayment event,
    Emitter<PaymentSettlementState> emit,
  ) async {
    try {
      emit(const PaymentSettlementState.loading());
      final result = await _paymentRepo.settlePayment(event.request);

      result.fold((error) => emit(PaymentSettlementState.failure(error)), (
        response,
      ) {
        emit(PaymentSettlementState.paymentSettled(response: response));
        // Start polling for payment status if checkout URL exists (payment gateway)
        if (response.checkoutUrl != null) {
          log(
            '[PaymentSettle] Payment gateway detected, starting polling for payment ID: ${response.data.paymentId}',
          );
          add(
            PaymentSettlementEvent.pollPaymentStatus(
              paymentId: response.data.paymentId,
            ),
          );
          // Don't refresh payments list during polling to avoid conflicts
        } else {
          log('[PaymentSettle] Cash payment completed');
          // Only refresh for cash payments
          add(const PaymentSettlementEvent.fetchPayments());
        }
      });
    } catch (e) {
      emit(PaymentSettlementState.failure("Error settling payment: $e"));
    }
  }

  Future<void> _onPollPaymentStatus(
    _PollPaymentStatus event,
    Emitter<PaymentSettlementState> emit,
  ) async {
    try {
      log(
        '[PaymentPolling] Checking payment status for payment ID: ${event.paymentId}',
      );

      final result = await _paymentRepo.getPaymentById(event.paymentId);

      result.fold(
        (error) {
          log('[PaymentPolling] Error: $error');
          emit(PaymentSettlementState.failure(error));
        },
        (response) {
          final payment = response.data;
          log('[PaymentPolling] Payment status: ${payment.status}');

          switch (payment.status) {
            case 'paid':
              log('[PaymentPolling] Payment completed!');
              emit(PaymentSettlementState.paymentCompleted(payment: payment));
              // Don't auto-refresh payments here - let UI handle it
              // This allows UI to refresh pending transactions first
              break;
            case 'failed':
              log('[PaymentPolling] Payment failed!');
              emit(
                PaymentSettlementState.paymentFailed(
                  payment: payment,
                  reason: 'Payment failed',
                ),
              );
              break;
            case 'expired':
              log('[PaymentPolling] Payment expired!');
              emit(PaymentSettlementState.paymentExpired(payment: payment));
              break;
            case 'pending':
              log(
                '[PaymentPolling] Payment still pending, scheduling next check...',
              );
              emit(PaymentSettlementState.paymentPolling(payment: payment));
              // Schedule next poll in 3 seconds
              Future.delayed(const Duration(seconds: 3), () {
                if (!isClosed) {
                  add(
                    PaymentSettlementEvent.pollPaymentStatus(
                      paymentId: event.paymentId,
                    ),
                  );
                }
              });
              break;
            default:
              log('[PaymentPolling] Unknown status: ${payment.status}');
              emit(
                PaymentSettlementState.failure(
                  'Unknown payment status: ${payment.status}',
                ),
              );
          }
        },
      );
    } catch (e) {
      log('[PaymentPolling] Exception: $e');
      emit(PaymentSettlementState.failure("Error polling payment status: $e"));
    }
  }

  Future<void> _onRetryPayment(
    _RetryPayment event,
    Emitter<PaymentSettlementState> emit,
  ) async {
    try {
      emit(const PaymentSettlementState.loading());
      final result = await _paymentRepo.retryPayment(event.paymentId);

      result.fold((error) => emit(PaymentSettlementState.failure(error)), (
        response,
      ) {
        emit(PaymentSettlementState.paymentRetried(response: response));
        // Start polling for the retried payment
        add(
          PaymentSettlementEvent.pollPaymentStatus(paymentId: event.paymentId),
        );
      });
    } catch (e) {
      emit(PaymentSettlementState.failure("Error retrying payment: $e"));
    }
  }

  Future<void> _onCancelPayment(
    _CancelPayment event,
    Emitter<PaymentSettlementState> emit,
  ) async {
    try {
      emit(const PaymentSettlementState.loading());
      final result = await _paymentRepo.cancelPayment(event.paymentId);

      result.fold((error) => emit(PaymentSettlementState.failure(error)), (
        response,
      ) {
        emit(PaymentSettlementState.paymentCancelled(response: response));
        // Refresh payments list
        add(const PaymentSettlementEvent.fetchPayments());
      });
    } catch (e) {
      emit(PaymentSettlementState.failure("Error cancelling payment: $e"));
    }
  }

  void _onStopPolling(
    _StopPolling event,
    Emitter<PaymentSettlementState> emit,
  ) {
    log('[PaymentPolling] Stopping polling');
    // No timer to cancel since we use self-triggering events
    emit(const PaymentSettlementState.initial());
  }
}
