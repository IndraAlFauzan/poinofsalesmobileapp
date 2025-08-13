import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/response/payment_method_model_response.dart';
import 'package:posmobile/data/repository/payment_method_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';
part 'payment_method_bloc.freezed.dart';

EventTransformer<E> _droppableThrottle<E>(Duration d) =>
    (events, mapper) => droppable<E>().call(events.throttle(d), mapper);

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  final PaymentMethodRepository _paymentMethodRepository;
  PaymentMethodBloc(this._paymentMethodRepository) : super(_Initial()) {
    on<_Started>(
      (event, emit) => add(const PaymentMethodEvent.fetchPaymentMethods()),
    );

    on<_FetchPaymentMethods>(
      _onFetchPaymentMethods,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );
  }

  Future<void> _onFetchPaymentMethods(
    _FetchPaymentMethods event,
    Emitter<PaymentMethodState> emit,
  ) async {
    try {
      emit(const PaymentMethodState.loading());
      final result = await _paymentMethodRepository.fetchPaymentMehod();

      result.fold(
        (error) => emit(PaymentMethodState.failure(error)),
        (response) =>
            emit(PaymentMethodState.success(paymentMethods: response.data)),
      );
    } catch (e) {
      emit(PaymentMethodState.failure("Error fetching payment methods: $e"));
    }
  }
}
