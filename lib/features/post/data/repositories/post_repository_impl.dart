import 'package:dartz/dartz.dart';
import 'package:tafaling/core/errors/failures.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/utils/failure_mapper.dart';
import 'package:tafaling/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/domain/entities/privacy_entity.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({required this.postDataSource, required this.networkInfo});

  @override
  ResultFuture<List<PostEntity>> fetchPosts(
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
  ResultFuture<List<PostEntity>> fetchUserPosts(
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

  @override
  ResultFuture<String> likePostComment(int commentId, int userId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await postDataSource.likePostComment(commentId, userId));
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  ResultFuture<String> updatePostPrivacy(
    int privacyId,
    int postId,
    int userId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          await postDataSource.updatePostPrivacy(privacyId, postId, userId),
        );
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  ResultFuture<String> updatePostComment(
    int commentId,
    String commentBody,
    int userId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          await postDataSource.updatePostComment(
            commentId,
            commentBody,
            userId,
          ),
        );
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  ResultFuture<String> sharePost(int privacyId, String body, int postId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await postDataSource.sharePost(privacyId, body, postId));
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  ResultFuture<List<PostEntity>> getUserSharedPosts(
    int postId,
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          await postDataSource.getUserSharedPosts(
            postId,
            userId,
            startRecord,
            pageSize,
          ),
        );
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  ResultFuture<List<PostEntity>> getUserPostComments(
    int postId,
    int userId,
    int parentCommentId,
    int startRecord,
    int pageSize,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          await postDataSource.getUserPostComments(
            postId,
            userId,
            parentCommentId,
            startRecord,
            pageSize,
          ),
        );
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  ResultFuture<String> deletePostComment(int commentId, int userId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await postDataSource.deletePostComment(commentId, userId));
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  ResultFuture<String> removePostCommentLike(int commentId, int userId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          await postDataSource.removePostCommentLike(commentId, userId),
        );
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  ResultFuture<String> commentOnPost(
    int parentCommentId,
    String commentBody,
    int postId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          await postDataSource.commentOnPost(
            parentCommentId,
            commentBody,
            postId,
          ),
        );
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  ResultFuture<List<PrivacyEntity>> getPrivacies() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await postDataSource.getPrivacies());
      } catch (e) {
        return Left(FailureMapper.fromException(e));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
