import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:tafaling/core/network/api_service.dart';
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

class UserProfileRemoteDataSourceImpl implements UsersRemoteDataSource {
  final ApiService authApiService;

  UserProfileRemoteDataSourceImpl({required this.authApiService});

  @override
  Future<FollowUnFollowModel> followUser(int followingUserId) async {
    final response = await authApiService.post(
      '/user/add/follower',
      data: {"following_user_id": followingUserId},
    );

    return _handleResponse<FollowUnFollowModel>(response, (data) {
      final likeData = data['data'];
      return FollowUnFollowModel(followingCount: likeData['FollowingCount']);
    });
  }

  @override
  Future<FollowUnFollowModel> unFollowUser(int followingUserId) async {
    final response = await authApiService.post(
      '/user/unfollow/user',
      data: {"following_user_id": followingUserId},
    );

    return _handleResponse<FollowUnFollowModel>(response, (data) {
      final likeData = data['data'];
      return FollowUnFollowModel(followingCount: likeData['FollowingCount']);
    });
  }

  @override
  Future<List<UserModel>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    final response = await authApiService.get(
      'user/search/profile/v2/$userId',
      queryParameters: {'start_record': startRecord, 'page_size': pageSize},
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      return (data['data'] as List)
          .map((user) => UserModel.fromJsonCammel(user))
          .toList();
    });
  }

  @override
  Future<List<UserModel>> searchUsers(
    int userId,
    String searchText,
    int startRecord,
    int pageSize,
  ) async {
    final response = await authApiService.get(
      '/user/search/user/$userId',
      queryParameters: {
        'start_record': startRecord,
        'page_size': pageSize,
        'search_text': searchText,
      },
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      return (data['data'] as List)
          .map((user) => UserModel.fromJsonCammel(user))
          .toList();
    });
  }

  @override
  Future<List<UserModel>> getFollowers(
    int targetUserId,
    int startRecord,
    int pageSize,
  ) async {
    final response = await authApiService.get(
      '/user/get/followers',
      queryParameters: {
        'target_user_id': targetUserId,
        'start_record': startRecord,
        'page_size': pageSize,
      },
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      return (data['data'] as List)
          .map((user) => UserModel.fromJsonForFollower(user))
          .toList();
    });
  }

  @override
  Future<List<UserModel>> getFollowingUsers(
    int targetUserId,
    int startRecord,
    int pageSize,
  ) async {
    final response = await authApiService.get(
      '/user/get/following/$targetUserId',
      queryParameters: {
        'target_user_id': targetUserId,
        'start_record': startRecord,
        'page_size': pageSize,
      },
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      return (data['data'] as List)
          .map((user) => UserModel.fromJsonForFollowing(user))
          .toList();
    });
  }

  @override
  Future<List<UserModel>> getSuggestedUsers(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    final response = await authApiService.get(
      '/user/profile/suggestion',
      queryParameters: {
        'userId': userId,
        'start_record': startRecord,
        'page_size': pageSize,
      },
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      return (data['data'] as List)
          .map((user) => UserModel.fromJsonForSuggestedUser(user))
          .toList();
    });
  }

  @override
  Future<UserModel> updateCoverPhoto(File coverPhoto) async {
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

    return _handleResponse<UserModel>(response, (data) {
      return UserModel.fromJsonCammel(data['data']);
    });
  }

  @override
  Future<UserModel> updateProfilePicture(File profilePhoto) async {
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

    return _handleResponse<UserModel>(response, (data) {
      return UserModel.fromJsonCammel(data['data']);
    });
  }

  @override
  Future<String> changePassword(
    String email,
    String password,
    String oldPassword,
  ) async {
    final response = await authApiService.post(
      '/auth/password-change',
      data: {'email': email, 'password': password, 'old_password': oldPassword},
    );

    return _handleResponse<String>(response, (data) {
      return data['message'] ?? 'Password changed successfully';
    });
  }

  Future<T> _handleResponse<T>(
    dynamic response,
    T Function(Map<String, dynamic>) parser,
  ) async {
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        final data = Map<String, dynamic>.from(response.data);
        return parser(data);
      } catch (e) {
        throw Exception('Failed to parse response data: ${e.toString()}');
      }
    } else {
      throw Exception(
        'Unexpected response: ${response.statusCode ?? 'No status'}, Body: ${response.data}',
      );
    }
  }
}
