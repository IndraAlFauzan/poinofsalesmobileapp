part of 'spicy_level_bloc.dart';

@freezed
class SpicyLevelEvent with _$SpicyLevelEvent {
  const factory SpicyLevelEvent.started() = _Started;
  const factory SpicyLevelEvent.fetchSpicyLevels() = _FetchSpicyLevels;
}
