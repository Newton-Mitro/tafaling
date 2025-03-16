import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/network_old/network_info.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkService networkService;

  AuthRepositoryImpl(this.remoteDataSource, this.networkService);

  @override
  Future<AuthUserModel> login(String email, String password) async {
    if (await networkService.isConnected == true) {
      try {
        return remoteDataSource.login(email, password);
      } on ServerException {
        throw Exception('Server exception.');
      }
    } else {
      try {
        // TODO: Local data source impl
        return remoteDataSource.login(email, password);
      } on CacheException {
        throw Exception('No local data found');
      }
    }
  }

  @override
  Future<AuthUserModel> register(String name, String email, String password,
      String confirmPassword) async {
    var result =
        await remoteDataSource.register(name, email, password, confirmPassword);
    return result as AuthUserModel;
  }

  @override
  Future<String> logout() async {
    await _clearToken();
    return remoteDataSource.logout();
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await AppSharedPref.getAccessToken();
    return token != null;
  }

  @override
  Future<AuthUserModel?> authUser() async {
    final user = await AppSharedPref.getAuthUser();
    final accessToken = await AppSharedPref.getAccessToken();
    final refreshToken = await AppSharedPref.getRefreshToken();
    if (user != null && accessToken != null && refreshToken != null) {
      return AuthUserModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        user: user,
      );
    }

    return null;
  }

  Future<void> _clearToken() async {
    await AppSharedPref.removeAccessToken();
    await AppSharedPref.removeRefreshToken();
    await AppSharedPref.removeAuthUser();
  }
}
