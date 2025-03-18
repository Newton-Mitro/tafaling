part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class RegisterEvent extends AuthEvent {
  final String name;
  final String password;
  final String email;
  final String confirmPassword;

  const RegisterEvent({
    required this.name,
    required this.password,
    required this.email,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [name, password, email, confirmPassword];
}

final class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

final class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
