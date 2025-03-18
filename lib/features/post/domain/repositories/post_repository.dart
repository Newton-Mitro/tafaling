import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/post/domain/entities/like_entity.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<DataState<List<PostEntity>>> fetchPosts(
    int userId,
    int startRecord,
    int pageSize,
  );
  Future<DataState<List<PostEntity>>> fetchUserPosts(
    int userId,
    int startRecord,
    int pageSize,
  );
  Future<DataState<LikeEntity>> likePost(int postId);
  Future<DataState<LikeEntity>> disLikePost(int postId);
}
