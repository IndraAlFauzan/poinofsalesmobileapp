part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.pressed({required LoginModelRequest req}) = _Pressed;
  const factory LoginEvent.clearError() = _ClearError;
}
