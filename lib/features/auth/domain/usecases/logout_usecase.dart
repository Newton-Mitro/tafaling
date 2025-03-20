import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

final class LogoutParams {}

class LogoutUsecase extends UseCase<void, LogoutParams> {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  @override
  Future<void> call({LogoutParams? params}) async {
    await authRepository.logout();
  }
}
