part of 'signup_screen_bloc.dart';

sealed class SignUpScreenEvent extends Equatable {
  const SignUpScreenEvent();

  @override
  List<Object?> get props => [];
}

final class RegisterEvent extends SignUpScreenEvent {
  final String name;
  final String password;
  final String email;
  final String confirmPassword;

  const RegisterEvent(
      this.name, this.password, this.email, this.confirmPassword);

  @override
  List<Object?> get props => [name, password, email, confirmPassword];
}

final class CheckLoginStatusEvent extends SignUpScreenEvent {
  const CheckLoginStatusEvent();
}

final class LogoutEvent extends SignUpScreenEvent {
  const LogoutEvent();
}
