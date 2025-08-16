import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/response/transaction_mode_response.dart';
import 'package:posmobile/data/repository/transaction_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'history_transaction_event.dart';
part 'history_transaction_state.dart';
part 'history_transaction_bloc.freezed.dart';

EventTransformer<E> _droppableThrottle<E>(Duration d) =>
    (events, mapper) => droppable<E>().call(events.throttle(d), mapper);

class HistoryTransactionBloc
    extends Bloc<HistoryTransactionEvent, HistoryTransactionState> {
  final TransactionRepository _transactionRepository;
  List<Transaction> _allTransactions = []; // Store all transactions for search
  TransactionFilter? _currentFilter;
  String _currentSearchQuery = '';

  // Getter to access current filter state
  TransactionFilter? get currentFilter => _currentFilter;
  String get currentSearchQuery => _currentSearchQuery;

  HistoryTransactionBloc(this._transactionRepository) : super(_Initial()) {
    on<_Started>(
      (event, emit) =>
          add(const HistoryTransactionEvent.fetchAllTransactions()),
    );
    on<_FetchAllTransactions>(
      _onFetchAllTransactions,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );
    on<_RefreshTransactions>(
      _onRefreshTransactions,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );
    on<_SearchTransactions>(
      _onSearchTransactions,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );
    on<_FilterTransactions>(
      _onFilterTransactions,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );
    on<_ClearFilters>(
      _onClearFilters,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );
  }

  Future<void> _onFetchAllTransactions(
    _FetchAllTransactions event,
    Emitter<HistoryTransactionState> emit,
  ) async {
    try {
      emit(const HistoryTransactionState.loading());
      final result = await _transactionRepository.fetchAllTransactionsHistory();

      result.fold((error) => emit(HistoryTransactionState.failure(error)), (
        response,
      ) {
        _allTransactions = response.data; // Store all transactions
        emit(HistoryTransactionState.success(response));
      });
    } catch (e) {
      emit(HistoryTransactionState.failure("Error fetching transactions: $e"));
    }
  }

  Future<void> _onRefreshTransactions(
    _RefreshTransactions event,
    Emitter<HistoryTransactionState> emit,
  ) async {
    try {
      emit(const HistoryTransactionState.refreshing());
      final result = await _transactionRepository.fetchAllTransactionsHistory();

      result.fold((error) => emit(HistoryTransactionState.failure(error)), (
        response,
      ) {
        _allTransactions = response.data; // Store all transactions
        emit(HistoryTransactionState.success(response));
      });
    } catch (e) {
      emit(
        HistoryTransactionState.failure("Error refreshing transactions: $e"),
      );
    }
  }

  Future<void> _onSearchTransactions(
    _SearchTransactions event,
    Emitter<HistoryTransactionState> emit,
  ) async {
    try {
      _currentSearchQuery = event.query.toLowerCase().trim();
      final filteredTransactions = _applyFiltersAndSearch();

      emit(
        HistoryTransactionState.success(
          AllTransactionModelResponse(
            success: true,
            message: _currentSearchQuery.isEmpty ? "Success" : "Search results",
            data: filteredTransactions,
          ),
        ),
      );
    } catch (e) {
      emit(HistoryTransactionState.failure("Error searching transactions: $e"));
    }
  }

  Future<void> _onFilterTransactions(
    _FilterTransactions event,
    Emitter<HistoryTransactionState> emit,
  ) async {
    try {
      _currentFilter = event.filter;
      final filteredTransactions = _applyFiltersAndSearch();

      emit(
        HistoryTransactionState.success(
          AllTransactionModelResponse(
            success: true,
            message: "Filtered results",
            data: filteredTransactions,
          ),
        ),
      );
    } catch (e) {
      emit(HistoryTransactionState.failure("Error filtering transactions: $e"));
    }
  }

  Future<void> _onClearFilters(
    _ClearFilters event,
    Emitter<HistoryTransactionState> emit,
  ) async {
    try {
      _currentFilter = null;
      _currentSearchQuery = '';
      final allTransactions = _applyFiltersAndSearch();

      emit(
        HistoryTransactionState.success(
          AllTransactionModelResponse(
            success: true,
            message: "Filters cleared",
            data: allTransactions,
          ),
        ),
      );
    } catch (e) {
      emit(HistoryTransactionState.failure("Error clearing filters: $e"));
    }
  }

  List<Transaction> _applyFiltersAndSearch() {
    var transactions = List<Transaction>.from(_allTransactions);

    // Apply search filter
    if (_currentSearchQuery.isNotEmpty) {
      transactions = transactions.where((transaction) {
        final transactionId = transaction.transactionId
            .toString()
            .toLowerCase();
        final orderNo = transaction.orderNo.toLowerCase();
        final customerName = transaction.customerName.toLowerCase();
        final status = transaction.status.toLowerCase();
        final grandTotal = transaction.grandTotal;
        final date = transaction.createdAtFormatted.toLowerCase();

        // Search in product names and details
        final hasMatchingProduct = transaction.details.any((detail) {
          final productName = detail.nameProduct.toLowerCase();
          final flavor = detail.flavor?.toLowerCase() ?? '';
          final spicyLevel = detail.spicyLevel?.toLowerCase() ?? '';
          final note = detail.note?.toLowerCase() ?? '';

          return productName.contains(_currentSearchQuery) ||
              flavor.contains(_currentSearchQuery) ||
              spicyLevel.contains(_currentSearchQuery) ||
              note.contains(_currentSearchQuery);
        });

        return transactionId.contains(_currentSearchQuery) ||
            orderNo.contains(_currentSearchQuery) ||
            customerName.contains(_currentSearchQuery) ||
            status.contains(_currentSearchQuery) ||
            grandTotal.contains(_currentSearchQuery) ||
            date.contains(_currentSearchQuery) ||
            hasMatchingProduct;
      }).toList();
    }

    // Apply filters
    if (_currentFilter != null) {
      final filter = _currentFilter!;

      // Filter by status
      if (filter.status != null && filter.status!.isNotEmpty) {
        transactions = transactions.where((transaction) {
          return transaction.status.toLowerCase() ==
              filter.status!.toLowerCase();
        }).toList();
      }

      // Filter by date range
      if (filter.startDate != null || filter.endDate != null) {
        transactions = transactions.where((transaction) {
          final transactionDate = transaction.createdAt;

          if (filter.startDate != null &&
              transactionDate.isBefore(filter.startDate!)) {
            return false;
          }

          if (filter.endDate != null &&
              transactionDate.isAfter(
                filter.endDate!.add(const Duration(days: 1)),
              )) {
            return false;
          }

          return true;
        }).toList();
      }

      // Filter by customer name
      if (filter.customerName != null && filter.customerName!.isNotEmpty) {
        transactions = transactions.where((transaction) {
          return transaction.customerName.toLowerCase().contains(
            filter.customerName!.toLowerCase(),
          );
        }).toList();
      }

      // Filter by amount range
      if (filter.minAmount != null || filter.maxAmount != null) {
        transactions = transactions.where((transaction) {
          final amount =
              double.tryParse(
                transaction.grandTotal
                    .replaceAll(',', '')
                    .replaceAll('.00', ''),
              ) ??
              0.0;

          if (filter.minAmount != null && amount < filter.minAmount!) {
            return false;
          }

          if (filter.maxAmount != null && amount > filter.maxAmount!) {
            return false;
          }

          return true;
        }).toList();
      }
    }

    return transactions;
  }
}
