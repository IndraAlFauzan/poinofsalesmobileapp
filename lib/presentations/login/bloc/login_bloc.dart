import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/request/login_model_request.dart';
import 'package:posmobile/data/model/response/login_model_response.dart';
import 'package:posmobile/data/repository/auth_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return (events, mapper) =>
      droppable<E>().call(events.throttle(duration), mapper);
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(_Initial()) {
    on<_Pressed>(
      _onPressed,
      transformer: _throttleDroppable(const Duration(milliseconds: 500)),
    );
    on<_ClearError>((event, emit) {
      // Reset back to initial (clear any failure message)
      emit(const LoginState.initial());
    });
  }

  Future<void> _onPressed(_Pressed event, Emitter<LoginState> emit) async {
    final email = event.req.email;
    final password = event.req.password;

    if (email.isEmpty || password.isEmpty) {
      emit(const LoginState.failure("Email dan password tidak boleh kosong"));
      return;
    }

    emit(const LoginState.loading());
    try {
      final result = await _authRepository.login(event.req);

      result.fold(
        (failure) => emit(LoginState.failure(failure)),
        (success) => emit(LoginState.success(success)),
      );
    } catch (e) {
      emit(LoginState.failure("Terdapat kesalahan: $e"));
    }
  }
}
