import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/core/network/network_info.dart';
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
  Future<DataState<AuthUserModel>> login(
      String? email, String? password) async {
    if (await networkService.isConnected == true) {
      try {
        final result = await remoteDataSource.login(
          email,
          password,
        );
        return SuccessData(result);
      } catch (e) {
        if (e is ValidationException) {
          return ValidationFailedData(ValidationFailure(e.errors));
        }

        if (e is UnauthorizedException) {
          return FailedData(UnauthorizedFailure());
        }

        return FailedData(ServerFailure());
      }
    } else {
      return FailedData(NetworkFailure());
    }
  }

  @override
  Future<DataState<AuthUserModel>> register(String name, String email,
      String password, String confirmPassword) async {
    if (await networkService.isConnected == true) {
      try {
        final result = await remoteDataSource.register(
          name,
          email,
          password,
          confirmPassword,
        );
        return SuccessData(result);
      } catch (e) {
        if (e is ValidationException) {
          return ValidationFailedData(ValidationFailure(e.errors));
        }

        if (e is UnauthorizedException) {
          return FailedData(UnauthorizedFailure());
        }

        return FailedData(ServerFailure());
      }
    } else {
      return FailedData(NetworkFailure());
    }
  }

  @override
  Future<DataState<void>> logout() async {
    if (await networkService.isConnected == true) {
      try {
        await _clearToken();
        final result = await remoteDataSource.logout();
        return SuccessData(result);
      } catch (e) {
        return FailedData(ServerFailure());
      }
    } else {
      return FailedData(NetworkFailure());
    }
  }

  @override
  Future<DataState<bool>> isLoggedIn() async {
    try {
      final token = await AppSharedPref.getAccessToken();
      return SuccessData(token != null);
    } catch (e) {
      return FailedData(ServerFailure());
    }
  }

  @override
  Future<DataState<AuthUserModel>> authUser() async {
    try {
      final user = await AppSharedPref.getAuthUser();
      final accessToken = await AppSharedPref.getAccessToken();
      final refreshToken = await AppSharedPref.getRefreshToken();
      if (user != null && accessToken != null && refreshToken != null) {
        return SuccessData(AuthUserModel(
          user: user,
          accessToken: accessToken,
          refreshToken: refreshToken,
        ));
      } else {
        return FailedData(ServerFailure(message: 'User not found'));
      }
    } catch (e) {
      return FailedData(ServerFailure());
    }
  }

  Future<DataState<void>> _clearToken() async {
    try {
      await AppSharedPref.removeAccessToken();
      await AppSharedPref.removeRefreshToken();
      await AppSharedPref.removeAuthUser();
      return SuccessData(null);
    } catch (e) {
      return FailedData(ServerFailure());
    }
  }
}
