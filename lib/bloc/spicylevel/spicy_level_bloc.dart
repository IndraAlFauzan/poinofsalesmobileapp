import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/response/spicy_level_model_response.dart';
import 'package:posmobile/data/repository/spicy_level_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'spicy_level_event.dart';
part 'spicy_level_state.dart';
part 'spicy_level_bloc.freezed.dart';

EventTransformer<E> _droppableThrottle<E>(Duration duration) {
  return (events, mapper) =>
      droppable<E>().call(events.throttle(duration), mapper);
}

class SpicyLevelBloc extends Bloc<SpicyLevelEvent, SpicyLevelState> {
  final SpicyLevelRepository _repo;
  SpicyLevelBloc(this._repo) : super(_Initial()) {
    on<_Started>(
      (event, emit) => add(const SpicyLevelEvent.fetchSpicyLevels()),
    );
    on<_FetchSpicyLevels>(
      _onFetch,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );
  }

  Future<void> _onFetch(
    _FetchSpicyLevels event,
    Emitter<SpicyLevelState> emit,
  ) async {
    try {
      emit(const SpicyLevelState.loading());
      final result = await _repo.fetchSpicyLevels();

      result.fold((failure) => emit(SpicyLevelState.failure(failure)), (
        response,
      ) {
        final spicyLevels = List<SpicyLevel>.from(response.data);
        emit(SpicyLevelState.success(spicyLevels));
      });
    } catch (e) {
      emit(SpicyLevelState.failure(e.toString()));
    }
  }
}
