part of 'history_transaction_bloc.dart';

@freezed
class HistoryTransactionState with _$HistoryTransactionState {
  const factory HistoryTransactionState.initial() = _Initial;
  const factory HistoryTransactionState.loading() = _Loading;
  const factory HistoryTransactionState.refreshing() = _Refreshing;
  const factory HistoryTransactionState.failure(String message) = _Failure;
  const factory HistoryTransactionState.success(
    AllTransactionModelResponse transactions,
  ) = _Success;
}
