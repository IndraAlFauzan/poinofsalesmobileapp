part of 'payment_page_bloc.dart';

@freezed
class PaymentPageState with _$PaymentPageState {
  const factory PaymentPageState.initial() = _Initial;

  const factory PaymentPageState.loaded({
    required List<Transaction> allTransactions,
    String? selectedTableNo,
    @Default([]) List<Transaction> selectedTransactions,
    @Default([]) List<String> availableTables,
    int? paymentMethodId,
    String? paymentMethodName,
    double? tenderedAmount,
    String? note,
  }) = _Loaded;
}
