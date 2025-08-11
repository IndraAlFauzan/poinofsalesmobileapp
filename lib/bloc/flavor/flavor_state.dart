part of 'flavor_bloc.dart';

@freezed
class FlavorState with _$FlavorState {
  const factory FlavorState.initial() = _Initial;
  const factory FlavorState.loading() = _Loading;
  const factory FlavorState.success(List<Flavor> flavors) = _Success;
  const factory FlavorState.failure(String message) = _Failure;
}
