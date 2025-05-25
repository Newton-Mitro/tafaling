import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordParams {
  final String email;
  ForgotPasswordParams(this.email);
}

class ForgotPasswordUseCase implements UseCase<int, ForgotPasswordParams> {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  @override
  ResultFuture<int> call(ForgotPasswordParams params) {
    return repository.forgotPassword(params.email);
  }
}
