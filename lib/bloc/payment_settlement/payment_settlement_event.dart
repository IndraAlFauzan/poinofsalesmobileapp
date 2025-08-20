part of 'payment_settlement_bloc.dart';

@freezed
class PaymentSettlementEvent with _$PaymentSettlementEvent {
  const factory PaymentSettlementEvent.started() = _Started;
  const factory PaymentSettlementEvent.fetchPayments() = _FetchPayments;
  const factory PaymentSettlementEvent.settlePayment({
    required PaymentSettleRequest request,
  }) = _SettlePayment;
  const factory PaymentSettlementEvent.pollPaymentStatus({
    required int paymentId,
  }) = _PollPaymentStatus;
  const factory PaymentSettlementEvent.retryPayment({required int paymentId}) =
      _RetryPayment;
  const factory PaymentSettlementEvent.cancelPayment({required int paymentId}) =
      _CancelPayment;
  const factory PaymentSettlementEvent.stopPolling() = _StopPolling;
}
