part of 'pending_transaction_bloc.dart';

@freezed
class PendingTransactionState with _$PendingTransactionState {
  const factory PendingTransactionState.initial() = _Initial;
  const factory PendingTransactionState.loading() = _Loading;
  const factory PendingTransactionState.success({
    required List<Transaction> transactions,
  }) = _Success;
  const factory PendingTransactionState.failure(String message) = _Failure;
  const factory PendingTransactionState.transactionCreated({
    required SingleTransactionResponse response,
  }) = _TransactionCreated;
  const factory PendingTransactionState.transactionUpdated({
    required TransactionResponse response,
  }) = _TransactionUpdated;
}
