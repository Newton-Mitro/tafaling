import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

final class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}

class LoginUseCase extends UseCase<DataState<AuthUserEntity>, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<DataState<AuthUserEntity>> call({LoginParams? params}) async {
    final loggedInUser = await repository.login(
      params?.email,
      params?.password,
    );

    return loggedInUser;
  }
}
