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

  HistoryTransactionBloc(this._transactionRepository) : super(_Initial()) {
    on<_Started>(
      (event, emit) =>
          add(const HistoryTransactionEvent.fetchAllTransactions()),
    );
    on<_FetchAllTransactions>(
      _onFetchAllTransactions,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );
    on<_SearchTransactions>(
      _onSearchTransactions,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );
  }

  Future<void> _onFetchAllTransactions(
    _FetchAllTransactions event,
    Emitter<HistoryTransactionState> emit,
  ) async {
    try {
      emit(const HistoryTransactionState.loading());
      final result = await _transactionRepository.fetchAllTransactions();

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

  Future<void> _onSearchTransactions(
    _SearchTransactions event,
    Emitter<HistoryTransactionState> emit,
  ) async {
    try {
      final query = event.query.toLowerCase().trim();

      if (query.isEmpty) {
        // If search is empty, return all transactions
        emit(
          HistoryTransactionState.success(
            AllTransactionModelResponse(
              success: true,
              message: "Success",
              data: _allTransactions,
            ),
          ),
        );
        return;
      }

      // Filter transactions based on multiple criteria
      final filteredTransactions = _allTransactions.where((transaction) {
        final transactionId = transaction.transactionId
            .toString()
            .toLowerCase();
        final userName = transaction.nameUser.toLowerCase();
        final paymentMethod = transaction.paymentMethod.toLowerCase();
        final total = transaction.total.toString();
        final date = transaction.createdAt.toIso8601String().toLowerCase();

        // Search in product names and details
        final hasMatchingProduct = transaction.details.any((detail) {
          final productName = detail.nameProduct.toLowerCase();
          final flavor = detail.flavor?.toLowerCase() ?? '';
          final spicyLevel = detail.spicyLevel?.toLowerCase() ?? '';
          final note = detail.note?.toLowerCase() ?? '';

          return productName.contains(query) ||
              flavor.contains(query) ||
              spicyLevel.contains(query) ||
              note.contains(query);
        });

        return transactionId.contains(query) ||
            userName.contains(query) ||
            paymentMethod.contains(query) ||
            total.contains(query) ||
            date.contains(query) ||
            hasMatchingProduct;
      }).toList();

      emit(
        HistoryTransactionState.success(
          AllTransactionModelResponse(
            success: true,
            message: "Search results",
            data: filteredTransactions,
          ),
        ),
      );
    } catch (e) {
      emit(HistoryTransactionState.failure("Error searching transactions: $e"));
    }
  }
}
