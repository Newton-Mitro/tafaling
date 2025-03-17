import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

final class AuthUserParams {}

class AuthUserUsecase
    extends UseCase<DataState<AuthUserEntity>, AuthUserParams> {
  final AuthRepository repository;

  AuthUserUsecase(this.repository);

  @override
  Future<DataState<AuthUserEntity>> call({AuthUserParams? params}) async {
    if (params == null) {
      throw Exception("Params cannot be null");
    }

    final loggedInUser = await repository.authUser();

    return loggedInUser;
  }
}
