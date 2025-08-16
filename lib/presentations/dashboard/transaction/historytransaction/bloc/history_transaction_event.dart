part of 'history_transaction_bloc.dart';

@freezed
class HistoryTransactionEvent with _$HistoryTransactionEvent {
  const factory HistoryTransactionEvent.started() = _Started;
  const factory HistoryTransactionEvent.fetchAllTransactions() =
      _FetchAllTransactions;
  const factory HistoryTransactionEvent.refreshTransactions() =
      _RefreshTransactions;
  const factory HistoryTransactionEvent.searchTransactions(String query) =
      _SearchTransactions;
  const factory HistoryTransactionEvent.filterTransactions(
    TransactionFilter filter,
  ) = _FilterTransactions;
  const factory HistoryTransactionEvent.clearFilters() = _ClearFilters;
}

class TransactionFilter {
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? customerName;
  final double? minAmount;
  final double? maxAmount;

  const TransactionFilter({
    this.status,
    this.startDate,
    this.endDate,
    this.customerName,
    this.minAmount,
    this.maxAmount,
  });

  TransactionFilter copyWith({
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    String? customerName,
    double? minAmount,
    double? maxAmount,
  }) {
    return TransactionFilter(
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      customerName: customerName ?? this.customerName,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionFilter &&
        other.status == status &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.customerName == customerName &&
        other.minAmount == minAmount &&
        other.maxAmount == maxAmount;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        customerName.hashCode ^
        minAmount.hashCode ^
        maxAmount.hashCode;
  }

  @override
  String toString() {
    return 'TransactionFilter(status: $status, startDate: $startDate, endDate: $endDate, customerName: $customerName, minAmount: $minAmount, maxAmount: $maxAmount)';
  }
}
