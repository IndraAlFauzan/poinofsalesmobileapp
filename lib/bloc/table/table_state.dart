part of 'table_bloc.dart';

@freezed
class TableState with _$TableState {
  const factory TableState.initial() = _Initial;
  const factory TableState.loading() = _Loading;
  const factory TableState.success(List<TableData> tables) = _Success;
  const factory TableState.failure(String message) = _Failure;
}
