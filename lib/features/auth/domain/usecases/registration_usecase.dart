import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
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

class RegistrationUseCase
    extends UseCase<DataState<AuthUserEntity>, RegistrationParams> {
  final AuthRepository authRepository;

  RegistrationUseCase({required this.authRepository});

  @override
  Future<DataState<AuthUserEntity>> call({RegistrationParams? params}) async {
    final authUser = await authRepository.register(
      params?.name ?? '',
      params?.email ?? '',
      params?.password ?? '',
      params?.confirmPassword ?? '',
    );

    return authUser;
  }
}
