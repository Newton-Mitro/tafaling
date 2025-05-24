import 'dart:io';

import 'package:tafaling/features/user/data/models/follow_un_follow_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

abstract class UsersDataSource {
  Future<FollowUnFollowModel> followUser(int followingUserId);

  Future<FollowUnFollowModel> unFollowUser(int followingUserId);

  Future<List<UserModel>> getFollowingUsers(
    int targetUserId,
    int startRecord,
    int pageSize,
  );

  Future<List<UserModel>> getFollowers(
    int targetUserId,
    int startRecord,
    int pageSize,
  );

  Future<List<UserModel>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  );

  Future<List<UserModel>> searchUsers(
    int userId,
    String searchText,
    int startRecord,
    int pageSize,
  );

  Future<List<UserModel>> getSuggestedUsers(
    int userId,
    int startRecord,
    int pageSize,
  );

  // updateCoverPhoto (/user/cover/picture/update)
  Future<UserModel> updateCoverPhoto(File coverPhoto);

  // updateProfilePicture (/user/profile/picture/update)
  Future<UserModel> updateProfilePicture(File profilePhoto);

  // changePassword (/auth/password-change)
  Future<String> changePassword(
    String email,
    String password,
    String oldPassword,
  );
}
