import 'package:equatable/equatable.dart';
import 'package:bloc_2026/features/login/data/models/login_response.dart';

class LoginState extends Equatable {
  final String message;
  final String usernameError;
  final String passwordError;
  final bool isLoading;
  final bool isFailure;
  final bool isSuccess;
  final LoginResponse? loginData;

  const LoginState({
    this.message = '',
    this.usernameError = '',
    this.passwordError = '',
    this.isLoading = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.loginData,
  });

  LoginState copyWith({
    String? message,
    String? usernameError,
    String? passwordError,
    bool? isLoading,
    bool? isFailure,
    bool? isSuccess,
    LoginResponse? loginData,
  }) {
    return LoginState(
      message: message ?? this.message,
      usernameError: usernameError ?? this.usernameError,
      passwordError: passwordError ?? this.passwordError,
      isLoading: isLoading ?? this.isLoading,
      isFailure: isFailure ?? this.isFailure,
      isSuccess: isSuccess ?? this.isSuccess,
      loginData: loginData ?? this.loginData,
    );
  }

  @override
  List<Object?> get props => [
        message,
        usernameError,
        passwordError,
        isLoading,
        isFailure,
        isSuccess,
        loginData,
      ];
}
