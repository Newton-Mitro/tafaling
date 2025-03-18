import 'dart:convert';
import 'dart:io';

import 'package:tafaling/core/network/api_service.dart';
import 'package:tafaling/core/network/auth_api_service.dart';
import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> fetchPosts(int userId, int startRecord, int pageSize);
  Future<List<PostModel>> fetchUserPosts(
    int userId,
    int startRecord,
    int pageSize,
  );
  Future<LikeModel> likePost(int postId);
  Future<LikeModel> disLikePost(int postId);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final ApiService apiService;
  final AuthApiService authApiService;

  PostRemoteDataSourceImpl({
    required this.apiService,
    required this.authApiService,
  });

  @override
  Future<List<PostModel>> fetchPosts(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    try {
      final response = await apiService.get(
        '/posts/v2/all/$userId',
        queryParameters: {'start_record': startRecord, 'page_size': pageSize},
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data!['data'];
        final List<PostModel> posts =
            (data as List).map((post) => PostModel.fromJson(post)).toList();
        return posts;
      } else {
        throw Exception('Post fetching failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PostModel>> fetchUserPosts(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    try {
      final response = await authApiService.get(
        '/posts/v2/user/$userId',
        queryParameters: {'start_record': startRecord, 'page_size': pageSize},
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data!['data'];
        final List<PostModel> posts =
            (data as List).map((post) => PostModel.fromJson(post)).toList();
        return posts;
      } else {
        throw Exception('Post fetching failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LikeModel> likePost(int postId) async {
    try {
      final response = await authApiService.post(
        '/posts/add_post_like',
        data: {"post_id": postId},
      );

      if (response.statusCode == HttpStatus.created) {
        final data = response.data!['data'];
        final decodedData = jsonDecode(data);
        final likeData = LikeModel.fromJson(decodedData);
        return likeData;
      } else {
        throw Exception('Post fetching failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LikeModel> disLikePost(int postId) async {
    try {
      final response = await authApiService.post(
        '/posts/remove_post_like',
        data: {"post_id": postId},
      );

      if (response.statusCode == HttpStatus.created) {
        final data = response.data!['data'];
        final decodedData = jsonDecode(data);
        final likeData = LikeModel.fromJson(decodedData);
        return likeData;
      } else {
        throw Exception('Post fetching failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<List<UserModel>> getFollowingUsers(int userId) async {
  //   final response = await authApiService.get(
  //     '/posts/liked/users',
  //     queryParameters: {'post_id': userId, 'start_record': 0, 'page_size': 5},
  //   );

  //   return _handleResponse<List<UserModel>>(response, (data) {
  //     var followers =
  //         (data['data'] as List)
  //             .map((user) => UserModel.fromJson(user))
  //             .toList();
  //     return followers;
  //   });
  // }
}

// POST http://127.0.0.1:8000/api/posts/remove
// Content-Type: application/json
// Accept: application/json
// Authorization: Bearer {{auth_token}}

// {
//     "post_id": 37
// }
