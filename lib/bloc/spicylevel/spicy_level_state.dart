part of 'spicy_level_bloc.dart';

@freezed
class SpicyLevelState with _$SpicyLevelState {
  const factory SpicyLevelState.initial() = _Initial;
  const factory SpicyLevelState.loading() = _Loading;
  const factory SpicyLevelState.success(List<SpicyLevel> spicyLevels) =
      _Success;
  const factory SpicyLevelState.failure(String message) = _Failure;
}
