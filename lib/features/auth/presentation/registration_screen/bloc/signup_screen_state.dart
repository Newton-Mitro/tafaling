part of 'signup_screen_bloc.dart';

sealed class SignUpScreenState extends Equatable {
  const SignUpScreenState();

  @override
  List<Object?> get props => [];
}

final class SignUpInitial extends SignUpScreenState {}

class SignUpLoading extends SignUpScreenState {}

class RegisteredCompleted extends SignUpScreenState {}

class SignedUp extends SignUpScreenState {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  const SignedUp(
      {required this.accessToken,
      required this.refreshToken,
      required this.user});

  @override
  List<Object?> get props => [accessToken, refreshToken, user];
}

class SignUpError extends SignUpScreenState {
  final String message;

  const SignUpError(this.message);

  @override
  List<Object?> get props => [message];
}

class SignUpValidationError extends SignUpScreenState {
  final Map<String, dynamic> errors;

  const SignUpValidationError(this.errors);

  @override
  List<Object?> get props => [errors];
}
