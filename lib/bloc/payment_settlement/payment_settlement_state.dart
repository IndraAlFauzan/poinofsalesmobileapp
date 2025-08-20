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
  const factory PaymentSettlementState.paymentPolling({
    required PaymentData payment,
  }) = _PaymentPolling;
  const factory PaymentSettlementState.paymentCompleted({
    required PaymentData payment,
  }) = _PaymentCompleted;
  const factory PaymentSettlementState.paymentFailed({
    required PaymentData payment,
    required String reason,
  }) = _PaymentFailed;
  const factory PaymentSettlementState.paymentExpired({
    required PaymentData payment,
  }) = _PaymentExpired;
  const factory PaymentSettlementState.paymentRetried({
    required PaymentRetryResponse response,
  }) = _PaymentRetried;
  const factory PaymentSettlementState.paymentCancelled({
    required PaymentCancelResponse response,
  }) = _PaymentCancelled;
  const factory PaymentSettlementState.failure(String message) = _Failure;
}
