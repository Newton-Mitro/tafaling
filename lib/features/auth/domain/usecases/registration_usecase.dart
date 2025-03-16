import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

final class RegistrationParams {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RegistrationParams({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class RegistrationUseCase extends UseCase<AuthUserModel, RegistrationParams> {
  final AuthRepository repository;

  RegistrationUseCase(this.repository);

  @override
  Future<AuthUserModel> call({RegistrationParams? params}) async {
    if (params == null) {
      throw Exception("Params cannot be null");
    }

    final authUser = await repository.register(
      params.name,
      params.email,
      params.password,
      params.confirmPassword,
    );

    return authUser as AuthUserModel;
  }
}
