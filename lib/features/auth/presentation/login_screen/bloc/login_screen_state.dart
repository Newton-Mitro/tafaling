part of 'login_screen_bloc.dart';

sealed class LoginScreenState extends Equatable {
  const LoginScreenState();

  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginScreenState {}

class LoginLoading extends LoginScreenState {}

class LoggedIn extends LoginScreenState {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  const LoggedIn(
      {required this.accessToken,
      required this.refreshToken,
      required this.user});

  @override
  List<Object?> get props => [accessToken, refreshToken, user];
}

class LoginError extends LoginScreenState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginValidationError extends LoginScreenState {
  final Map<String, dynamic> errors;

  const LoginValidationError(this.errors);

  @override
  List<Object?> get props => [errors];
}
