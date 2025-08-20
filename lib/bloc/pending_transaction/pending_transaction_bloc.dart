import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/request/create_transaction_request.dart';
import 'package:posmobile/data/model/request/edit_transaction_request.dart';
import 'package:posmobile/data/model/response/transaction_model.dart';
import 'package:posmobile/data/repository/transaction_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'pending_transaction_event.dart';
part 'pending_transaction_state.dart';
part 'pending_transaction_bloc.freezed.dart';

EventTransformer<E> _droppableThrottle<E>(Duration duration) {
  return (events, mapper) =>
      droppable<E>().call(events.throttle(duration), mapper);
}

class PendingTransactionBloc
    extends Bloc<PendingTransactionEvent, PendingTransactionState> {
  final TransactionRepository _transactionRepository;

  PendingTransactionBloc(this._transactionRepository)
    : super(const _Initial()) {
    on<_Started>(
      (event, emit) =>
          add(const PendingTransactionEvent.fetchPendingTransactions()),
    );

    on<_FetchPendingTransactions>(
      _onFetchPendingTransactions,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );

    on<_CreateTransaction>(
      _onCreateTransaction,
      transformer: _droppableThrottle(const Duration(milliseconds: 500)),
    );

    on<_EditTransaction>(
      _onEditTransaction,
      transformer: _droppableThrottle(const Duration(milliseconds: 500)),
    );

    on<_RefreshTransactions>(
      (event, emit) =>
          add(const PendingTransactionEvent.fetchPendingTransactions()),
    );
  }

  Future<void> _onFetchPendingTransactions(
    _FetchPendingTransactions event,
    Emitter<PendingTransactionState> emit,
  ) async {
    try {
      emit(const PendingTransactionState.loading());
      final result = await _transactionRepository.fetchPendingTransactions();

      result.fold((error) => emit(PendingTransactionState.failure(error)), (
        response,
      ) {
        if (response.success) {
          emit(PendingTransactionState.success(transactions: response.data));
        } else {
          emit(PendingTransactionState.failure(response.message));
        }
      });
    } catch (e) {
      emit(PendingTransactionState.failure(e.toString()));
    }
  }

  Future<void> _onCreateTransaction(
    _CreateTransaction event,
    Emitter<PendingTransactionState> emit,
  ) async {
    try {
      emit(const PendingTransactionState.loading());
      final result = await _transactionRepository.createTransaction(
        event.request,
      );

      result.fold((error) => emit(PendingTransactionState.failure(error)), (
        response,
      ) {
        emit(PendingTransactionState.transactionCreated(response: response));
        // After creating, refresh the pending transactions list
        add(const PendingTransactionEvent.fetchPendingTransactions());
      });
    } catch (e) {
      emit(PendingTransactionState.failure("Error creating transaction: $e"));
    }
  }

  Future<void> _onEditTransaction(
    _EditTransaction event,
    Emitter<PendingTransactionState> emit,
  ) async {
    try {
      // Don't emit loading state for edit to avoid UI flicker
      final result = await _transactionRepository.editTransaction(
        event.transactionId,
        event.request,
      );

      result.fold((error) => emit(PendingTransactionState.failure(error)), (
        response,
      ) {
        emit(PendingTransactionState.transactionUpdated(response: response));
        // After editing, refresh the pending transactions list
        add(const PendingTransactionEvent.fetchPendingTransactions());
      });
    } catch (e) {
      emit(PendingTransactionState.failure("Error editing transaction: $e"));
    }
  }
}
