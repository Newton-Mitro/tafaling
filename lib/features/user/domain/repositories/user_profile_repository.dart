import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/user/domain/entities/follow_unfollow_entity.dart';
import 'package:tafaling/features/user/domain/entities/search_user_entity.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

abstract class UserProfileRepository {
  Future<DataState<FollowUnFollowEntity>> followUser(int followingUserId);
  Future<DataState<FollowUnFollowEntity>> unFollowUser(int followingUserId);
  Future<DataState<List<PostEntity>>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  );
  Future<DataState<List<SearchUserEntity>>> searchUsers(
    int userId,
    String searchText,
    int startRecord,
    int pageSize,
  );

  Future<DataState<List<UserEntity>>> getFollowingUsers(
    int targetUserId,
    int startRecord,
    int pageSize,
  );
  Future<DataState<List<UserEntity>>> getFollowers(
    int targetUserId,
    int startRecord,
    int pageSize,
  );
}
