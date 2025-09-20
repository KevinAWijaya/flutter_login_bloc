import 'package:equatable/equatable.dart';
import 'package:wisdom_pos_test/data/models/response/response_login.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final ResponseLogin? user;
  final bool rememberMe;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.user,
    this.rememberMe = false,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStatus? status,
    ResponseLogin? user,
    bool? rememberMe,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      rememberMe: rememberMe ?? this.rememberMe,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, rememberMe, errorMessage];
}
