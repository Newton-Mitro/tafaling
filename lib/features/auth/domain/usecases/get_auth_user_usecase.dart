import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class GetAuthUserUseCase extends UseCase<AuthUserEntity, NoParams> {
  final AuthRepository authRepository;

  GetAuthUserUseCase({required this.authRepository});

  @override
  ResultFuture<AuthUserEntity> call(NoParams? params) async {
    final loggedInUser = await authRepository.getAuthUser();
    return loggedInUser;
  }
}
