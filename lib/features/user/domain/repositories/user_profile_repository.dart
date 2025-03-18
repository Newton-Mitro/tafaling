import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/data/models/follow_un_follow_model.dart';
import 'package:tafaling/features/user/data/models/search_user_model.dart';

abstract class UserProfileRepository {
  Future<DataState<FollowUnFollowModel>> followUser(int followingUserId);
  Future<DataState<FollowUnFollowModel>> unFollowUser(int followingUserId);
  Future<DataState<List<PostModel>>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  );
  Future<DataState<List<SearchUserModel>>> searchUsers(
    int userId,
    String searchText,
    int startRecord,
    int pageSize,
  );
}
