import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class LoginUseCase extends UseCase<AuthUserModel, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<AuthUserModel> call({LoginParams? params}) async {
    if (params == null) {
      throw Exception("Params cannot be null");
    }

    final loggedInUser = await repository.login(params.email, params.password);

    return loggedInUser as AuthUserModel;
  }
}
