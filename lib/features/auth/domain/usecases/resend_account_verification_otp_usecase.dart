import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class ResendAccountVerificationOtpParams {
  final String email;
  ResendAccountVerificationOtpParams(this.email);
}

class ResendAccountVerificationOtpUseCase
    implements UseCase<String, ResendAccountVerificationOtpParams> {
  final AuthRepository repository;

  ResendAccountVerificationOtpUseCase(this.repository);

  @override
  ResultFuture<String> call(ResendAccountVerificationOtpParams params) {
    return repository.resendAccountVerificationOtp(params.email);
  }
}
