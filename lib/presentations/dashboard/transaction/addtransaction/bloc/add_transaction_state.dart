part of 'add_transaction_bloc.dart';

@freezed
class AddTransactionState with _$AddTransactionState {
  const factory AddTransactionState.initial() = _Initial;
  const factory AddTransactionState.loading() = _Loading;
  const factory AddTransactionState.success(
    GetByIdTransactionModelResponse response,
  ) = _Success;
  const factory AddTransactionState.failure(String message) = _Failure;
}
