import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

class ChangePasswordParams {
  final String email;
  final String newPassword;
  final String oldPassword;

  ChangePasswordParams({
    required this.email,
    required this.newPassword,
    required this.oldPassword,
  });
}

class ChangePasswordUseCase implements UseCase<String, ChangePasswordParams> {
  final UserRepository repository;

  ChangePasswordUseCase(this.repository);

  @override
  ResultFuture<String> call(ChangePasswordParams params) {
    return repository.changePassword(
      params.email,
      params.newPassword,
      params.oldPassword,
    );
  }
}
