import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/features/post/domain/entities/like_entity.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
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
}
