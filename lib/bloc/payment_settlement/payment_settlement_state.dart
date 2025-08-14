part of 'payment_settlement_bloc.dart';

@freezed
class PaymentSettlementState with _$PaymentSettlementState {
  const factory PaymentSettlementState.initial() = _Initial;
  const factory PaymentSettlementState.loading() = _Loading;
  const factory PaymentSettlementState.paymentsLoaded({
    required List<PaymentData> payments,
  }) = _PaymentsLoaded;
  const factory PaymentSettlementState.paymentSettled({
    required PaymentSettleResponse response,
  }) = _PaymentSettled;
  const factory PaymentSettlementState.failure(String message) = _Failure;
}
