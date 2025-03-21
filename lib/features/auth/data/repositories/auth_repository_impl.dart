import 'package:tafaling/core/constants/constants.dart';
import 'package:tafaling/core/index.dart';
import 'package:tafaling/features/auth/data/index.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final NetworkInfo networkInfo;
  final LocalStorage localStorage;

  AuthRepositoryImpl({
    required this.authDataSource,
    required this.networkInfo,
    required this.localStorage,
  });

  @override
  Future<DataState<AuthUserModel>> login(
    String? email,
    String? password,
  ) async {
    if (await networkInfo.isConnected == true) {
      try {
        final result = await authDataSource.login(email, password);
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
  Future<DataState<AuthUserModel>> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (await networkInfo.isConnected == true) {
      try {
        final result = await authDataSource.register(
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
    if (await networkInfo.isConnected == true) {
      try {
        final result = await authDataSource.logout();
        await _clearToken();
        return SuccessData(result);
      } catch (e) {
        return FailedData(ServerFailure());
      }
    } else {
      return FailedData(NetworkFailure());
    }
  }

  Future<DataState<void>> _clearToken() async {
    try {
      await localStorage.remove(Constants.accessTokenKey);
      await localStorage.remove(Constants.refreshTokenKey);
      await localStorage.remove(Constants.authUserKey);
      authUserNotifier.value = null;
      accessTokenNotifier.value = null;
      selectedPageNotifier.value = 0;
      return SuccessData(null);
    } catch (e) {
      return FailedData(ServerFailure());
    }
  }
}
