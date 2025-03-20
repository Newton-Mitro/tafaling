import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/user/data/data_sources/user_data_source.dart';
import 'package:tafaling/features/user/data/models/follow_un_follow_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UsersDataSource remoteDataSource;
  final NetworkService networkService;

  UserRepositoryImpl(this.remoteDataSource, this.networkService);

  @override
  Future<DataState<FollowUnFollowModel>> followUser(int followingUserId) async {
    if (await networkService.isConnected == true) {
      try {
        final result = await remoteDataSource.followUser(followingUserId);
        return SuccessData(result);
      } catch (e) {
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
  Future<DataState<FollowUnFollowModel>> unFollowUser(
    int followingUserId,
  ) async {
    if (await networkService.isConnected == true) {
      try {
        final result = await remoteDataSource.unFollowUser(followingUserId);
        return SuccessData(result);
      } catch (e) {
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
  Future<DataState<List<UserModel>>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkService.isConnected == true) {
      try {
        var posts = await remoteDataSource.fetchProfile(
          userId,
          startRecord,
          pageSize,
        );
        return SuccessData(posts);
      } catch (e) {
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
  Future<DataState<List<UserEntity>>> searchUsers(
    int userId,
    String searchText,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkService.isConnected == true) {
      try {
        var users = await remoteDataSource.searchUsers(
          userId,
          searchText,
          startRecord,
          pageSize,
        );
        return SuccessData(users);
      } catch (e) {
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
  Future<DataState<List<UserEntity>>> getFollowers(
    int targetUserId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkService.isConnected == true) {
      try {
        var users = await remoteDataSource.getFollowers(
          targetUserId,
          startRecord,
          pageSize,
        );
        return SuccessData(users);
      } catch (e) {
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
  Future<DataState<List<UserEntity>>> getFollowingUsers(
    int targetUserId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkService.isConnected == true) {
      try {
        var users = await remoteDataSource.getFollowingUsers(
          targetUserId,
          startRecord,
          pageSize,
        );
        return SuccessData(users);
      } catch (e) {
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
  Future<DataState<List<UserEntity>>> getSuggestedUsers(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkService.isConnected == true) {
      try {
        var users = await remoteDataSource.getSuggestedUsers(
          userId,
          startRecord,
          pageSize,
        );
        return SuccessData(users);
      } catch (e) {
        if (e is UnauthorizedException) {
          return FailedData(UnauthorizedFailure());
        }
        return FailedData(ServerFailure());
      }
    } else {
      return FailedData(NetworkFailure());
    }
  }
}
