import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthRepository {
  ResultFuture<AuthUserEntity> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
  ResultFuture<AuthUserEntity> login(String? email, String? password);
  ResultFuture<void> logout();
  ResultFuture<AuthUserEntity> getAuthUser();
}
