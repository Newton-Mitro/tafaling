import 'dart:io';

import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/features/user/domain/entities/follow_unfollow_entity.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  ResultFuture<FollowUnFollowEntity> followUser(int followingUserId);

  ResultFuture<FollowUnFollowEntity> unFollowUser(int followingUserId);

  ResultFuture<List<UserEntity>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  );

  ResultFuture<List<UserEntity>> searchUsers(
    int userId,
    String searchText,
    int startRecord,
    int pageSize,
  );

  ResultFuture<List<UserEntity>> getFollowingUsers(
    int targetUserId,
    int startRecord,
    int pageSize,
  );

  ResultFuture<List<UserEntity>> getFollowers(
    int targetUserId,
    int startRecord,
    int pageSize,
  );

  ResultFuture<List<UserEntity>> getSuggestedUsers(
    int userId,
    int startRecord,
    int pageSize,
  );

  ResultFuture<UserEntity> updateCoverPhoto(File coverPhoto);

  ResultFuture<UserEntity> updateProfilePicture(File profilePhoto);

  ResultFuture<String> changePassword(
    String email,
    String password,
    String oldPassword,
  );
}
