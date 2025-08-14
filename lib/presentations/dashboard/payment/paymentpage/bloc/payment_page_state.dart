part of 'payment_page_bloc.dart';

@freezed
class PaymentPageState with _$PaymentPageState {
  const factory PaymentPageState.initial() = _Initial;

  const factory PaymentPageState.loaded({
    required List<PendingTransaction> allTransactions,
    String? selectedTableNo,
    @Default([]) List<PendingTransaction> selectedTransactions,
    @Default([]) List<String> availableTables,
  }) = _Loaded;
}
