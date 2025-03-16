import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

final class LogoutParams {}

class LogoutUsecase extends UseCase<void, LogoutParams> {
  final AuthRepository repository;

  LogoutUsecase(this.repository);

  @override
  Future<void> call({LogoutParams? params}) async {
    await repository.logout();
  }
}
