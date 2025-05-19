import 'package:dartz/dartz.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/utils/failure_mapper.dart';
import 'package:tafaling/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({required this.postDataSource, required this.networkInfo});

  @override
  ResultFuture<List<PostModel>> fetchPosts(
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

        return Right(posts);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      try {
        var posts = await postDataSource.fetchPosts(
          userId,
          startRecord,
          pageSize,
        );

        return Right(posts);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    }
  }

  @override
  ResultFuture<List<PostModel>> fetchUserPosts(
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

        return Right(posts);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      try {
        var posts = await postDataSource.fetchUserPosts(
          userId,
          startRecord,
          pageSize,
        );

        return Right(posts);
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    }
  }

  @override
  ResultFuture<LikeModel> likePost(int postId) async {
    if (await networkInfo.isConnected == true) {
      try {
        return Right(await postDataSource.likePost(postId));
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      try {
        return Right(await postDataSource.likePost(postId));
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    }
  }

  @override
  ResultFuture<LikeModel> disLikePost(int postId) async {
    if (await networkInfo.isConnected == true) {
      try {
        return Right(await postDataSource.disLikePost(postId));
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      try {
        return Right(await postDataSource.disLikePost(postId));
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    }
  }

  @override
  ResultFuture<List<UserEntity>> getLikeUserByPost(
    int postId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkInfo.isConnected == true) {
      try {
        return Right(
          await postDataSource.getLikeUserByPost(postId, startRecord, pageSize),
        );
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      try {
        return Right(
          await postDataSource.getLikeUserByPost(postId, startRecord, pageSize),
        );
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    }
  }
}
