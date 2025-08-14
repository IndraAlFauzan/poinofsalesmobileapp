part of 'pending_transaction_bloc.dart';

@freezed
class PendingTransactionEvent with _$PendingTransactionEvent {
  const factory PendingTransactionEvent.started() = _Started;
  const factory PendingTransactionEvent.fetchPendingTransactions() =
      _FetchPendingTransactions;
  const factory PendingTransactionEvent.createTransaction({
    required CreateTransactionRequest request,
  }) = _CreateTransaction;
  const factory PendingTransactionEvent.editTransaction({
    required int transactionId,
    required EditTransactionRequest request,
  }) = _EditTransaction;
  const factory PendingTransactionEvent.refreshTransactions() =
      _RefreshTransactions;
}
