import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wisdom_pos_test/core/globals.dart' as globals;
import 'package:wisdom_pos_test/data/repositories/auth_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<ToggleRememberMe>(_onToggleRememberMe);
    on<InitialLoginCheck>(_onInitialLoginCheck);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      status: LoginStatus.loading,
      email: event.email,
      password: event.password,
    ));

    try {
      final user = await authRepository.login(
        username: event.email,
        password: event.password,
      );

      emit(state.copyWith(
        status: LoginStatus.success,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.toString(),
      ));
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
    if (state.rememberMe && state.email.isNotEmpty && state.password.isNotEmpty) {
      emit(state.copyWith(status: LoginStatus.loading));
      add(LoginSubmitted(state.email, state.password));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LoginState> emit,
  ) async {
    globals.accessToken = null;
    emit(const LoginState());
    await clear();
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) => LoginState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LoginState state) => state.toJson();
}
