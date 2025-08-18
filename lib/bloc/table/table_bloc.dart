import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/response/table_response.dart';
import 'package:posmobile/data/repository/table_repository.dart';

part 'table_event.dart';
part 'table_state.dart';
part 'table_bloc.freezed.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final TableRepository _tableRepository;

  TableBloc(this._tableRepository) : super(const TableState.initial()) {
    on<_FetchTables>(_onFetchTables);
  }

  Future<void> _onFetchTables(
    _FetchTables event,
    Emitter<TableState> emit,
  ) async {
    emit(const TableState.loading());

    final result = await _tableRepository.getTables();

    result.fold(
      (error) => emit(TableState.failure(error)),
      (response) => emit(TableState.success(response.data)),
    );
  }
}
