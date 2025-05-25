import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpParams {
  final String email;
  final String otp;

  VerifyOtpParams({required this.email, required this.otp});
}

class VerifyForgotPasswordOtpUseCase implements UseCase<int, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyForgotPasswordOtpUseCase(this.repository);

  @override
  ResultFuture<int> call(VerifyOtpParams params) {
    return repository.verifyForgotPasswordOtp(params.email, params.otp);
  }
}
