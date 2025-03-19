import 'dart:convert';
import 'dart:io';

import 'package:tafaling/core/network/auth_api_service.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/data/models/follow_un_follow_model.dart';
import 'package:tafaling/features/user/data/models/search_user_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

abstract class UserProfileRemoteDataSource {
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
  Future<List<PostModel>> fetchProfile(
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
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final AuthApiService authApiService;

  UserProfileRemoteDataSourceImpl({required this.authApiService});

  @override
  Future<FollowUnFollowModel> followUser(int followingUserId) async {
    final response = await authApiService.post(
      '/user/add/follower',
      data: {"following_user_id": followingUserId},
    );

    return _handleResponse<FollowUnFollowModel>(response, (data) {
      var likeData = jsonDecode(data['data']);
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
      var likeData = jsonDecode(data['data']);
      return FollowUnFollowModel(followingCount: likeData['FollowingCount']);
    });
  }

  @override
  Future<List<PostModel>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    final response = await authApiService.get(
      '/user/search/profile/$userId',
      queryParameters: {'start_record': startRecord, 'page_size': pageSize},
    );

    return _handleResponse<List<PostModel>>(response, (data) {
      var posts =
          (data['data'] as List)
              .map((post) => PostModel.fromJson(post))
              .toList();
      return posts;
    });
  }

  // user/search/profile/v2/1?start_record=0&page_size=3
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
      var posts =
          (data['data'] as List)
              .map((post) => UserModel.fromJson(post))
              .toList();
      return posts;
    });
  }

  Future<T> _handleResponse<T>(
    dynamic response,
    T Function(Map<String, dynamic>) parser,
  ) async {
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        final data = response.data as Map<String, dynamic>;
        return parser(data);
      } catch (e) {
        throw Exception('Failed to parse response data: ${e.toString()}');
      }
    } else {
      throw Exception(
        'Unexpected response: ${response.statusCode}, ${response.data}',
      );
    }
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
        'start_record': 0,
        'page_size': 5,
      },
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      var followers =
          (data['data'] as List)
              .map((user) => UserModel.fromJson(user))
              .toList();
      return followers;
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
        'start_record': 0,
        'page_size': 5,
      },
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      var followers =
          (data['data'] as List)
              .map((user) => UserModel.fromJson(user))
              .toList();
      return followers;
    });
  }
}
