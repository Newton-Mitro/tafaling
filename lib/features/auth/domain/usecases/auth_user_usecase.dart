import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

final class AuthUserParams {}

class AuthUserUsecase extends UseCase<AuthUserModel?, AuthUserParams> {
  final AuthRepository repository;

  AuthUserUsecase(this.repository);

  @override
  Future<AuthUserModel?> call({AuthUserParams? params}) async {
    if (params == null) {
      throw Exception("Params cannot be null");
    }

    final loggedInUser = await repository.authUser();

    return loggedInUser as AuthUserModel;
  }
}
