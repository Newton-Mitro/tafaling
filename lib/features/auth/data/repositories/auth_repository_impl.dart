import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/core/network_old/network_info.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkService networkService;

  AuthRepositoryImpl(this.remoteDataSource, this.networkService);

  @override
  Future<ResponseState<AuthUserModel>> login(
      String email, String password) async {
    if (await networkService.isConnected == true) {
      try {
        final result = await remoteDataSource.login(
          email,
          password,
        );
        return ResponseSuccess(result);
      } catch (e) {
        return ResponseFailed(ServerFailure(e.toString()));
      }
    } else {
      return ResponseFailed(NetworkFailure());
    }
  }

  @override
  Future<ResponseState<AuthUserModel>> register(String name, String email,
      String password, String confirmPassword) async {
    if (await networkService.isConnected == true) {
      try {
        final result = await remoteDataSource.register(
          name,
          email,
          password,
          confirmPassword,
        );
        return ResponseSuccess(result);
      } catch (e) {
        return ResponseFailed(ServerFailure(e.toString()));
      }
    } else {
      return ResponseFailed(NetworkFailure());
    }
  }

  @override
  Future<ResponseState<void>> logout() async {
    if (await networkService.isConnected == true) {
      try {
        await _clearToken();
        final result = await remoteDataSource.logout();
        return ResponseSuccess(result);
      } catch (e) {
        return ResponseFailed(ServerFailure(e.toString()));
      }
    } else {
      return ResponseFailed(NetworkFailure());
    }
  }

  @override
  Future<ResponseState<bool>> isLoggedIn() async {
    try {
      final token = await AppSharedPref.getAccessToken();
      return ResponseSuccess(token != null);
    } catch (e) {
      return ResponseFailed(ServerFailure(e.toString()));
    }
  }

  @override
  Future<ResponseState<AuthUserModel>> authUser() async {
    try {
      final user = await AppSharedPref.getAuthUser();
      final accessToken = await AppSharedPref.getAccessToken();
      final refreshToken = await AppSharedPref.getRefreshToken();
      if (user != null && accessToken != null && refreshToken != null) {
        return ResponseSuccess(AuthUserModel(
          user: user,
          accessToken: accessToken,
          refreshToken: refreshToken,
        ));
      } else {
        return ResponseFailed(ServerFailure('User not found'));
      }
    } catch (e) {
      return ResponseFailed(ServerFailure(e.toString()));
    }
  }

  Future<ResponseState<void>> _clearToken() async {
    try {
      await AppSharedPref.removeAccessToken();
      await AppSharedPref.removeRefreshToken();
      await AppSharedPref.removeAuthUser();
      return ResponseSuccess(null);
    } catch (e) {
      return ResponseFailed(ServerFailure(e.toString()));
    }
  }
}
