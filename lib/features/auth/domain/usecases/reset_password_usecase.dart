import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordParams {
  final String email;
  final String password;
  final String passwordConfirmation;
  final String token;

  ResetPasswordParams({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.token,
  });
}

class ResetPasswordUseCase implements UseCase<int, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  ResultFuture<int> call(ResetPasswordParams params) {
    return repository.resetPassword(
      params.email,
      params.password,
      params.passwordConfirmation,
      params.token,
    );
  }
}
