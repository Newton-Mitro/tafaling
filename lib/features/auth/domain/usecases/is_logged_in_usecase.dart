import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

final class IsLoggedInParams {}

class IsLoggedInUsecase extends UseCase<ResponseState<bool>, IsLoggedInParams> {
  final AuthRepository repository;

  IsLoggedInUsecase(this.repository);

  @override
  Future<ResponseState<bool>> call({IsLoggedInParams? params}) async {
    return await repository.isLoggedIn();
  }
}
