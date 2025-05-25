import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:tafaling/core/network/api_service.dart';
import 'package:tafaling/core/utils/json_util.dart';
import 'package:tafaling/features/user/data/models/follow_un_follow_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

abstract class UsersRemoteDataSource {
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
  Future<UserModel> updateCoverPhoto(File coverPhoto);
  Future<UserModel> updateProfilePicture(File profilePhoto);
  Future<String> changePassword(
    String email,
    String password,
    String oldPassword,
  );
}

class UserProfileRemoteDataSourceImpl implements UsersRemoteDataSource {
  final ApiService authApiService;

  UserProfileRemoteDataSourceImpl({required this.authApiService});

  @override
  Future<FollowUnFollowModel> followUser(int followingUserId) async {
    try {
      final response = await authApiService.post(
        '/user/add/follower',
        data: {"following_user_id": followingUserId},
      );

      if (response.statusCode == HttpStatus.created) {
        final data = response.data['data'];
        final jsonData = JsonUtil.decodeModel(data);
        return FollowUnFollowModel.fromJson(jsonData);
      } else {
        throw Exception('Follow user failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FollowUnFollowModel> unFollowUser(int followingUserId) async {
    try {
      final response = await authApiService.post(
        '/user/unfollow/user',
        data: {"following_user_id": followingUserId},
      );

      if (response.statusCode == HttpStatus.created) {
        final data = response.data['data'];
        final jsonData = JsonUtil.decodeModel(data);
        return FollowUnFollowModel.fromJson(jsonData);
      } else {
        throw Exception('Unfollow user failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    try {
      final response = await authApiService.get(
        'user/search/profile/v2/$userId',
        queryParameters: {'start_record': startRecord, 'page_size': pageSize},
      );

      if (response.statusCode == HttpStatus.ok) {
        final List data = response.data['data'];
        return data.map((user) => UserModel.fromJsonCammel(user)).toList();
      } else {
        throw Exception('Fetch profile failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> searchUsers(
    int userId,
    String searchText,
    int startRecord,
    int pageSize,
  ) async {
    try {
      final response = await authApiService.get(
        '/user/search/user/$userId',
        queryParameters: {
          'start_record': startRecord,
          'page_size': pageSize,
          'search_text': searchText,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final List data = response.data['data'];
        return data.map((user) => UserModel.fromJsonCammel(user)).toList();
      } else {
        throw Exception('Search users failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getFollowers(
    int targetUserId,
    int startRecord,
    int pageSize,
  ) async {
    try {
      final response = await authApiService.get(
        '/user/get/followers',
        queryParameters: {
          'target_user_id': targetUserId,
          'start_record': startRecord,
          'page_size': pageSize,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final List data = response.data['data'];
        return data.map((user) => UserModel.fromJsonForFollower(user)).toList();
      } else {
        throw Exception('Get followers failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getFollowingUsers(
    int targetUserId,
    int startRecord,
    int pageSize,
  ) async {
    try {
      final response = await authApiService.get(
        '/user/get/following/$targetUserId',
        queryParameters: {
          'target_user_id': targetUserId,
          'start_record': startRecord,
          'page_size': pageSize,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final List data = response.data['data'];
        return data
            .map((user) => UserModel.fromJsonForFollowing(user))
            .toList();
      } else {
        throw Exception('Get following users failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getSuggestedUsers(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    try {
      final response = await authApiService.get(
        '/user/profile/suggestion',
        queryParameters: {
          'userId': userId,
          'start_record': startRecord,
          'page_size': pageSize,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final List data = response.data['data'];
        return data
            .map((user) => UserModel.fromJsonForSuggestedUser(user))
            .toList();
      } else {
        throw Exception('Get suggested users failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> updateCoverPhoto(File coverPhoto) async {
    try {
      final mimeType = lookupMimeType(coverPhoto.path)?.split('/');
      final formData = FormData.fromMap({
        'coverPhoto': await MultipartFile.fromFile(
          coverPhoto.path,
          filename: coverPhoto.uri.pathSegments.last,
          contentType:
              mimeType != null
                  ? MediaType(mimeType[0], mimeType[1])
                  : MediaType('image', 'png'),
        ),
      });

      final response = await authApiService.post(
        '/user/cover/picture/update',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        return UserModel.fromJsonCammel(response.data['data']);
      } else {
        throw Exception('Update cover photo failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> updateProfilePicture(File profilePhoto) async {
    try {
      final mimeTypeData =
          lookupMimeType(profilePhoto.path)?.split('/') ?? ['image', 'png'];

      final formData = FormData.fromMap({
        'profilePhoto': await MultipartFile.fromFile(
          profilePhoto.path,
          filename: profilePhoto.uri.pathSegments.last,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      });

      final response = await authApiService.post(
        '/user/profile/picture/update',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        return UserModel.fromJsonCammel(response.data['data']);
      } else {
        throw Exception('Update profile picture failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> changePassword(
    String email,
    String password,
    String oldPassword,
  ) async {
    try {
      final response = await authApiService.post(
        '/auth/password-change',
        data: {
          'email': email,
          'password': password,
          'old_password': oldPassword,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        return response.data['message'] ?? 'Password changed successfully';
      } else {
        throw Exception('Change password failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}
