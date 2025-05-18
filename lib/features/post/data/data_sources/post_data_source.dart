import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

abstract class PostDataSource {
  Future<List<PostModel>> fetchPosts(int userId, int startRecord, int pageSize);
  Future<List<PostModel>> fetchUserPosts(
    int userId,
    int startRecord,
    int pageSize,
  );
  Future<String> removePost(int postId);
  Future<LikeModel> likePost(int postId);
  Future<LikeModel> disLikePost(int postId);
  Future<List<UserModel>> getLikeUserByPost(
    int postId,
    int startRecord,
    int pageSize,
  );
}
