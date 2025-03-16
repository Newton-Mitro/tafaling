import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<ResponseState<AuthUserEntity>> register(
      String name, String email, String password, String confirmPassword);
  Future<ResponseState<AuthUserEntity>> login(String email, String password);
  Future<ResponseState<void>> logout();
  Future<ResponseState<bool>> isLoggedIn();
  Future<ResponseState<AuthUserEntity>> authUser();
}
