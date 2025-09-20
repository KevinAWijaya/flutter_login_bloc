import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisdom_pos_test/data/repositories/auth_repository.dart';
import 'package:wisdom_pos_test/data/repositories/session_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final SessionRepository sessionRepository;

  LoginBloc(this.authRepository, this.sessionRepository) : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<ToggleRememberMe>(_onToggleRememberMe);
    on<InitialLoginCheck>(_onInitialLoginCheck);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final user = await authRepository.login(
        username: event.email,
        password: event.password,
      );

      if (state.rememberMe) {
        await sessionRepository.saveCredentials(
          event.email.trim(),
          event.password.trim(),
          true,
        );
      } else {
        await sessionRepository.clearCredentials();
      }

      emit(state.copyWith(status: LoginStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onToggleRememberMe(
    ToggleRememberMe event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      rememberMe: !state.rememberMe,
      status: LoginStatus.initial,
      errorMessage: null,
    ));
  }

  Future<void> _onInitialLoginCheck(
    InitialLoginCheck event,
    Emitter<LoginState> emit,
  ) async {
    final (username, password, rememberMe) = await sessionRepository.loadCredentials();

    if (rememberMe && username != null && username.isNotEmpty && password != null && password.isNotEmpty) {
      emit(state.copyWith(rememberMe: true));
      add(LoginSubmitted(username, password));
    }
  }
}
