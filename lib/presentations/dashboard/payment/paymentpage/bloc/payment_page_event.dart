part of 'payment_page_bloc.dart';

@freezed
class PaymentPageEvent with _$PaymentPageEvent {
  const factory PaymentPageEvent.updateTransactions({
    required List<PendingTransaction> transactions,
  }) = _UpdateTransactions;

  const factory PaymentPageEvent.selectTable({String? tableNo}) = _SelectTable;

  const factory PaymentPageEvent.toggleTransactionSelection({
    required PendingTransaction transaction,
  }) = _ToggleTransactionSelection;

  const factory PaymentPageEvent.clearSelections() = _ClearSelections;

  const factory PaymentPageEvent.validateTableSelection() =
      _ValidateTableSelection;

  const factory PaymentPageEvent.setPaymentInfo({
    required int paymentMethodId,
    required String paymentMethodName,
    double? tenderedAmount,
    String? note,
  }) = _SetPaymentInfo;
}
