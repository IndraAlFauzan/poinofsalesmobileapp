import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/request/payment_settle_request.dart';
import 'package:posmobile/data/model/response/payment_response.dart';
import 'package:posmobile/data/repository/transaction_repository.dart';
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
  final TransactionRepository _transactionRepository;

  PaymentSettlementBloc(this._transactionRepository) : super(const _Initial()) {
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
  }

  Future<void> _onFetchPayments(
    _FetchPayments event,
    Emitter<PaymentSettlementState> emit,
  ) async {
    try {
      emit(const PaymentSettlementState.loading());
      final result = await _transactionRepository.fetchPayments();

      result.fold(
        (error) => emit(PaymentSettlementState.failure(error)),
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
      final result = await _transactionRepository.settlePayment(event.request);

      result.fold((error) => emit(PaymentSettlementState.failure(error)), (
        response,
      ) {
        emit(PaymentSettlementState.paymentSettled(response: response));
        // After settling, refresh the payments list
        add(const PaymentSettlementEvent.fetchPayments());
      });
    } catch (e) {
      emit(PaymentSettlementState.failure("Error settling payment: $e"));
    }
  }
}
