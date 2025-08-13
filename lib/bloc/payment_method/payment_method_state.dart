part of 'payment_method_bloc.dart';

@freezed
class PaymentMethodState with _$PaymentMethodState {
  const factory PaymentMethodState.initial() = _Initial;
  const factory PaymentMethodState.loading() = _Loading;
  const factory PaymentMethodState.success({
    required List<Payment> paymentMethods,
  }) = _Loaded;
  const factory PaymentMethodState.failure(String message) = _Error;
}
