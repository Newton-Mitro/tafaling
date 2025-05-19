import 'package:dartz/dartz.dart';
import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  LogoutUseCase({required this.authRepository});

  @override
  ResultFuture<void> call(NoParams params) async {
    await authRepository.logout();
    return const Right(null);
  }
}
