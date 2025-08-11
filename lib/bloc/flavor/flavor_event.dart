part of 'flavor_bloc.dart';

@freezed
class FlavorEvent with _$FlavorEvent {
  const factory FlavorEvent.started() = _Started;
  const factory FlavorEvent.fetchFlavors() = _FetchFlavors;
}
