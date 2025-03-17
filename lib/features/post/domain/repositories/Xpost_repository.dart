import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';

abstract class XPostRepository {
  Future<DataState<List<PostEntity>>> getPosts(
      int userId, int startRecord, int pageSize);
  Future<DataState<List<PostEntity>>> getUserPosts(
      int userId, int startRecord, int pageSize);
  Future<DataState<LikeModel>> likePost(int postId);
  Future<DataState<LikeModel>> disLikePost(int postId);
}
