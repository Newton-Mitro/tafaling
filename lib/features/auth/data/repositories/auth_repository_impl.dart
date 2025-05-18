import 'package:dartz/dartz.dart';
import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/utils/failure_mapper.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_data_source.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/features/auth/domain/entities/auth_user_entity.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<AuthUserModel> login(String? email, String? password) async {
    if (await networkInfo.isConnected == true) {
      try {
        final result = await authRemoteDataSource.login(email, password);
        return Right(result);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  ResultFuture<AuthUserModel> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (await networkInfo.isConnected == true) {
      try {
        final result = await authRemoteDataSource.register(
          name,
          email,
          password,
          confirmPassword,
        );
        return Right(result);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  ResultFuture<void> logout() async {
    if (await networkInfo.isConnected == true) {
      try {
        await authRemoteDataSource.logout();
        await authLocalDataSource.clearAuthUser();

        return const Right(null);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  ResultFuture<AuthUserEntity> getAuthUser() async {
    try {
      final authUser = await authLocalDataSource.getAuthUser();
      return Right(authUser);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
