import 'package:dartz/dartz.dart';
import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/utils/failure_mapper.dart';
import 'package:tafaling/features/user/data/data_sources/users_remote_data_source.dart';
import 'package:tafaling/features/user/data/models/follow_un_follow_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UsersRemoteDataSource usersRemoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.usersRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<FollowUnFollowModel> followUser(int followingUserId) async {
    if (await networkInfo.isConnected == true) {
      try {
        final result = await usersRemoteDataSource.followUser(followingUserId);
        return Right(result);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  ResultFuture<FollowUnFollowModel> unFollowUser(int followingUserId) async {
    if (await networkInfo.isConnected == true) {
      try {
        final result = await usersRemoteDataSource.unFollowUser(
          followingUserId,
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
  ResultFuture<List<UserModel>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkInfo.isConnected == true) {
      try {
        var posts = await usersRemoteDataSource.fetchProfile(
          userId,
          startRecord,
          pageSize,
        );
        return Right(posts);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  ResultFuture<List<UserEntity>> searchUsers(
    int userId,
    String searchText,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkInfo.isConnected == true) {
      try {
        var users = await usersRemoteDataSource.searchUsers(
          userId,
          searchText,
          startRecord,
          pageSize,
        );
        return Right(users);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  ResultFuture<List<UserEntity>> getFollowers(
    int targetUserId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkInfo.isConnected == true) {
      try {
        var users = await usersRemoteDataSource.getFollowers(
          targetUserId,
          startRecord,
          pageSize,
        );
        return Right(users);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  ResultFuture<List<UserEntity>> getFollowingUsers(
    int targetUserId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkInfo.isConnected == true) {
      try {
        var users = await usersRemoteDataSource.getFollowingUsers(
          targetUserId,
          startRecord,
          pageSize,
        );
        return Right(users);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  ResultFuture<List<UserEntity>> getSuggestedUsers(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkInfo.isConnected == true) {
      try {
        var users = await usersRemoteDataSource.getSuggestedUsers(
          userId,
          startRecord,
          pageSize,
        );
        return Right(users);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
