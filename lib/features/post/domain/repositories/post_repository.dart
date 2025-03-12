import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> fetchPosts(int userId, int startRecord, int pageSize);
  Future<List<PostModel>> fetchUserPosts(
      int userId, int startRecord, int pageSize);
  Future<LikeModel> likePost(int postId);
  Future<LikeModel> disLikePost(int postId);
}
