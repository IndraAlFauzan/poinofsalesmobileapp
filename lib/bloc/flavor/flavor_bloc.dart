import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/response/flavor_model_response.dart';
import 'package:posmobile/data/repository/flavor_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'flavor_event.dart';
part 'flavor_state.dart';
part 'flavor_bloc.freezed.dart';

EventTransformer<E> _droppableThrottle<E>(Duration duration) {
  return (events, mapper) =>
      droppable<E>().call(events.throttle(duration), mapper);
}

class FlavorBloc extends Bloc<FlavorEvent, FlavorState> {
  final FlavorRepository _repo;
  FlavorBloc(this._repo) : super(_Initial()) {
    on<_Started>((event, emit) => add(const FlavorEvent.fetchFlavors()));
    on<_FetchFlavors>(
      _onFetch,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );
  }

  Future<void> _onFetch(_FetchFlavors event, Emitter<FlavorState> emit) async {
    emit(const FlavorState.loading());
    final result = await _repo.fetchFlavors();

    result.fold((failure) => emit(FlavorState.failure(failure)), (response) {
      final flavors = List<Flavor>.from(response.data);
      emit(FlavorState.success(flavors));
    });
  }
}
