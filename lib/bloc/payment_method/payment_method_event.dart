part of 'payment_method_bloc.dart';

@freezed
class PaymentMethodEvent with _$PaymentMethodEvent {
  const factory PaymentMethodEvent.started() = _Started;
  const factory PaymentMethodEvent.fetchPaymentMethods() = _FetchPaymentMethods;
}
