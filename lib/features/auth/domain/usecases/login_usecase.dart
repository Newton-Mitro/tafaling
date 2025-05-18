import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

final class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class LoginUseCase extends UseCase<AuthUserEntity, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  ResultFuture<AuthUserEntity> call(LoginParams? params) async {
    final loggedInUser = await authRepository.login(
      params?.email,
      params?.password,
    );

    return loggedInUser;
  }
}
