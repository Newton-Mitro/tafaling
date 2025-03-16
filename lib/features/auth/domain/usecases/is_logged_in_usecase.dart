import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

final class IsLoggedInParams {}

class IsLoggedInUsecase extends UseCase<bool, IsLoggedInParams> {
  final AuthRepository repository;

  IsLoggedInUsecase(this.repository);

  @override
  Future<bool> call({IsLoggedInParams? params}) async {
    return await repository.isLoggedIn();
  }
}
