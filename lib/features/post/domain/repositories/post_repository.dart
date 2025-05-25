import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/features/post/domain/entities/like_entity.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/domain/entities/privacy_entity.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

abstract class PostRepository {
  ResultFuture<List<PostEntity>> fetchPosts(
    int userId,
    int startRecord,
    int pageSize,
  );
  ResultFuture<List<PostEntity>> fetchUserPosts(
    int userId,
    int startRecord,
    int pageSize,
  );
  ResultFuture<List<UserEntity>> getLikeUserByPost(
    int postId,
    int startRecord,
    int pageSize,
  );
  ResultFuture<LikeEntity> likePost(int postId);
  ResultFuture<LikeEntity> disLikePost(int postId);

  ResultFuture<String> likePostComment(int commentId, int userId);
  ResultFuture<String> updatePostPrivacy(int privacyId, int postId, int userId);
  ResultFuture<String> updatePostComment(
    int commentId,
    String commentBody,
    int userId,
  );
  ResultFuture<String> sharePost(int privacyId, String body, int postId);
  ResultFuture<List<PostEntity>> getUserSharedPosts(
    int postId,
    int userId,
    int startRecord,
    int pageSize,
  );
  ResultFuture<List<PostEntity>> getUserPostComments(
    int postId,
    int userId,
    int parentCommentId,
    int startRecord,
    int pageSize,
  );
  ResultFuture<String> deletePostComment(int commentId, int userId);
  ResultFuture<String> removePostCommentLike(int commentId, int userId);
  ResultFuture<String> commentOnPost(
    int parentCommentId,
    String commentBody,
    int postId,
  );

  ResultFuture<List<PrivacyEntity>> getPrivacies();
}
