import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final NetworkService networkService;

  PostRepositoryImpl(this.remoteDataSource, this.networkService);

  @override
  Future<DataState<List<PostModel>>> fetchPosts(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkService.isConnected == true) {
      try {
        var posts = await remoteDataSource.fetchPosts(
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
      try {
        // TODO: Local data source impl
        var posts = await remoteDataSource.fetchPosts(
          userId,
          startRecord,
          pageSize,
        );

        return SuccessData(posts);
      } catch (e) {
        if (e is CacheException) {
          return FailedData(CacheFailure());
        }
        return FailedData(ServerFailure());
      }
    }
  }

  @override
  Future<DataState<List<PostModel>>> fetchUserPosts(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkService.isConnected == true) {
      try {
        var posts = await remoteDataSource.fetchUserPosts(
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
      try {
        // TODO: Local data source impl
        var posts = await remoteDataSource.fetchUserPosts(
          userId,
          startRecord,
          pageSize,
        );

        return SuccessData(posts);
      } catch (e) {
        if (e is CacheException) {
          return FailedData(CacheFailure());
        }
        return FailedData(ServerFailure());
      }
    }
  }

  @override
  Future<DataState<LikeModel>> likePost(int postId) async {
    if (await networkService.isConnected == true) {
      try {
        return SuccessData(await remoteDataSource.likePost(postId));
      } catch (e) {
        if (e is UnauthorizedException) {
          return FailedData(UnauthorizedFailure());
        }
        return FailedData(ServerFailure());
      }
    } else {
      try {
        // TODO: Local data source impl
        return SuccessData(await remoteDataSource.likePost(postId));
      } catch (e) {
        if (e is CacheException) {
          return FailedData(CacheFailure());
        }
        return FailedData(ServerFailure());
      }
    }
  }

  @override
  Future<DataState<LikeModel>> disLikePost(int postId) async {
    if (await networkService.isConnected == true) {
      try {
        return SuccessData(await remoteDataSource.disLikePost(postId));
      } catch (e) {
        if (e is UnauthorizedException) {
          return FailedData(UnauthorizedFailure());
        }
        return FailedData(ServerFailure());
      }
    } else {
      try {
        // TODO: Local data source impl
        return SuccessData(await remoteDataSource.disLikePost(postId));
      } catch (e) {
        if (e is CacheException) {
          return FailedData(CacheFailure());
        }
        return FailedData(ServerFailure());
      }
    }
  }

  @override
  Future<DataState<List<UserEntity>>> getLikeUserByPost(
    int postId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkService.isConnected == true) {
      try {
        return SuccessData(
          await remoteDataSource.getLikeUserByPost(
            postId,
            startRecord,
            pageSize,
          ),
        );
      } catch (e) {
        if (e is UnauthorizedException) {
          return FailedData(UnauthorizedFailure());
        }
        return FailedData(ServerFailure());
      }
    } else {
      try {
        // TODO: Local data source impl
        return SuccessData(
          await remoteDataSource.getLikeUserByPost(
            postId,
            startRecord,
            pageSize,
          ),
        );
      } catch (e) {
        if (e is CacheException) {
          return FailedData(CacheFailure());
        }
        return FailedData(ServerFailure());
      }
    }
  }
}
