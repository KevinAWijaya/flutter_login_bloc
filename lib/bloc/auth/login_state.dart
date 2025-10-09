import 'package:equatable/equatable.dart';
import 'package:wisdom_pos_test/data/models/response/response_login.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final ResponseLogin? user;
  final bool rememberMe;
  final String? errorMessage;
  final String email;
  final String password;

  const LoginState({
    this.status = LoginStatus.initial,
    this.user,
    this.rememberMe = false,
    this.errorMessage,
    this.email = '',
    this.password = '',
  });

  LoginState copyWith({
    LoginStatus? status,
    ResponseLogin? user,
    bool? rememberMe,
    String? errorMessage,
    String? email,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      rememberMe: rememberMe ?? this.rememberMe,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [status, user, rememberMe, errorMessage, email, password];

  // ✅ HydratedBloc serialization
  Map<String, dynamic> toJson() => {
        'status': status.name,
        'rememberMe': rememberMe,
        'errorMessage': errorMessage,
        'email': email,
        'password': password,
        'user': user?.toJson(),
      };

  static LoginState fromJson(Map<String, dynamic> json) {
    return LoginState(
      status: LoginStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'initial'),
        orElse: () => LoginStatus.initial,
      ),
      rememberMe: json['rememberMe'] ?? false,
      errorMessage: json['errorMessage'],
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      user: json['user'] != null ? ResponseLogin.fromJson(json['user']) : null,
    );
  }
}
