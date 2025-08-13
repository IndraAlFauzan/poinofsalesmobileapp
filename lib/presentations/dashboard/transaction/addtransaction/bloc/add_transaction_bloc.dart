import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/request/transaction_model_request.dart';
import 'package:posmobile/data/model/response/transaction_mode_response.dart';
import 'package:posmobile/data/repository/transaction_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'add_transaction_event.dart';
part 'add_transaction_state.dart';
part 'add_transaction_bloc.freezed.dart';

EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return (events, mapper) =>
      droppable<E>().call(events.throttle(duration), mapper);
}

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  final TransactionRepository _transactionRepository;
  AddTransactionBloc(this._transactionRepository) : super(_Initial()) {
    on<_AddTransaction>(
      _onAddTransaction,
      transformer: _throttleDroppable(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onAddTransaction(
    _AddTransaction event,
    Emitter<AddTransactionState> emit,
  ) async {
    emit(const AddTransactionState.loading());
    try {
      final response = await _transactionRepository.submitTransaction(
        event.req,
      );

      response.fold(
        (failure) => emit(AddTransactionState.failure(failure)),
        (success) => emit(AddTransactionState.success(success)),
      );
    } catch (e) {
      emit(AddTransactionState.failure("Error adding transaction: $e"));
    }
  }
}
