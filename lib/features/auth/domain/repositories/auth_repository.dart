import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<String> register(
      String name, String email, String password, String confirmPassword);
  Future<AuthUserEntity> login(String email, String password);
  Future<String> logout();
}
