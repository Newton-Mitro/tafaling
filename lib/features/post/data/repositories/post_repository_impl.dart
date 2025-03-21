import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/post/data/data_sources/post_data_source.dart';
import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource postDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({required this.postDataSource, required this.networkInfo});

  @override
  Future<DataState<List<PostModel>>> fetchPosts(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkInfo.isConnected == true) {
      try {
        var posts = await postDataSource.fetchPosts(
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
        var posts = await postDataSource.fetchPosts(
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
    if (await networkInfo.isConnected == true) {
      try {
        var posts = await postDataSource.fetchUserPosts(
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
        var posts = await postDataSource.fetchUserPosts(
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
    if (await networkInfo.isConnected == true) {
      try {
        return SuccessData(await postDataSource.likePost(postId));
      } catch (e) {
        if (e is UnauthorizedException) {
          return FailedData(UnauthorizedFailure());
        }
        return FailedData(ServerFailure());
      }
    } else {
      try {
        // TODO: Local data source impl
        return SuccessData(await postDataSource.likePost(postId));
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
    if (await networkInfo.isConnected == true) {
      try {
        return SuccessData(await postDataSource.disLikePost(postId));
      } catch (e) {
        if (e is UnauthorizedException) {
          return FailedData(UnauthorizedFailure());
        }
        return FailedData(ServerFailure());
      }
    } else {
      try {
        // TODO: Local data source impl
        return SuccessData(await postDataSource.disLikePost(postId));
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
    if (await networkInfo.isConnected == true) {
      try {
        return SuccessData(
          await postDataSource.getLikeUserByPost(postId, startRecord, pageSize),
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
          await postDataSource.getLikeUserByPost(postId, startRecord, pageSize),
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
