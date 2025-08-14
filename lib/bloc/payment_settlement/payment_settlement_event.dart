part of 'payment_settlement_bloc.dart';

@freezed
class PaymentSettlementEvent with _$PaymentSettlementEvent {
  const factory PaymentSettlementEvent.started() = _Started;
  const factory PaymentSettlementEvent.fetchPayments() = _FetchPayments;
  const factory PaymentSettlementEvent.settlePayment({
    required PaymentSettleRequest request,
  }) = _SettlePayment;
}
