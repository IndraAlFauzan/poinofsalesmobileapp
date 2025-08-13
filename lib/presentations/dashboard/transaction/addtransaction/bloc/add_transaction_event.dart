part of 'add_transaction_bloc.dart';

@freezed
class AddTransactionEvent with _$AddTransactionEvent {
  const factory AddTransactionEvent.started() = _Started;
  const factory AddTransactionEvent.addTransaction({
    required TransactionModelRequest req,
  }) = _AddTransaction;
}
