import 'package:bloc/bloc.dart';
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
  HistoryTransactionBloc(this._transactionRepository) : super(_Initial()) {
    on<_Started>(
      (event, emit) =>
          add(const HistoryTransactionEvent.fetchAllTransactions()),
    );
    on<_FetchAllTransactions>(
      _onFetchAllTransactions,
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

      result.fold(
        (error) => emit(HistoryTransactionState.failure(error)),
        (response) => emit(HistoryTransactionState.success(response)),
      );
    } catch (e) {
      emit(HistoryTransactionState.failure("Error fetching transactions: $e"));
    }
  }
}
