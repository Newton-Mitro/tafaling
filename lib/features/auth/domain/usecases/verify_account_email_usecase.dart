import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class VerifyAccountParams {
  final String userAgent;
  final String ip;
  final String email;
  final String otp;

  VerifyAccountParams({
    required this.userAgent,
    required this.ip,
    required this.email,
    required this.otp,
  });
}

class VerifyAccountEmailUseCase
    implements UseCase<AuthUserEntity, VerifyAccountParams> {
  final AuthRepository repository;

  VerifyAccountEmailUseCase(this.repository);

  @override
  ResultFuture<AuthUserEntity> call(VerifyAccountParams params) {
    return repository.verifiyAccountEmail(
      params.userAgent,
      params.ip,
      params.email,
      params.otp,
    );
  }
}
