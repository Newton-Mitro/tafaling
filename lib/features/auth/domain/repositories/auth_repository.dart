import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<DataState<AuthUserEntity>> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
  Future<DataState<AuthUserEntity>> login(String? email, String? password);
  Future<DataState<void>> logout();
  Future<DataState<AuthUserEntity>> getAuthUser();
}
