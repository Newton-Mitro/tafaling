import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

final class GetAuthUserParams {}

class GetAuthUserUseCase extends UseCase<AuthUserEntity, GetAuthUserParams> {
  final AuthRepository authRepository;

  GetAuthUserUseCase({required this.authRepository});

  @override
  ResultFuture<AuthUserEntity> call(GetAuthUserParams? params) async {
    final loggedInUser = await authRepository.getAuthUser();
    return loggedInUser;
  }
}
