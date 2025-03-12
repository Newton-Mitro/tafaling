import 'dart:convert';
import 'dart:io';

import 'package:tafaling/core/network_old/api_service.dart';
import 'package:tafaling/core/network_old/auth_api_service.dart';
import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> fetchPosts(int userId, int startRecord, int pageSize);
  Future<List<PostModel>> fetchUserPosts(
      int userId, int startRecord, int pageSize);
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
      int userId, int startRecord, int pageSize) async {
    final response = await apiService.get(
      '/posts/all/$userId',
      queryParameters: {
        'start_record': startRecord,
        'page_size': pageSize,
      },
    );

    return _handleResponse<List<PostModel>>(response, (data) {
      var posts = (data['data'] as List)
          .map((post) => PostModel.fromJson(post))
          .toList();
      return posts;
    });
  }

  @override
  Future<List<PostModel>> fetchUserPosts(
      int userId, int startRecord, int pageSize) async {
    final response = await authApiService.get(
      '/posts/user/$userId',
      queryParameters: {
        'start_record': startRecord,
        'page_size': pageSize,
      },
    );

    return _handleResponse<List<PostModel>>(response, (data) {
      var posts = (data['data'] as List)
          .map((post) => PostModel.fromJson(post))
          .toList();
      return posts;
    });
  }

  @override
  Future<LikeModel> likePost(int postId) async {
    final response = await authApiService.post(
      '/posts/add_post_like',
      data: {"post_id": postId},
    );

    return _handleResponse<LikeModel>(response, (data) {
      var likeData = jsonDecode(data['data']);
      return LikeModel(likeCount: likeData['LikeCount']);
    });
  }

  @override
  Future<LikeModel> disLikePost(int postId) async {
    final response = await authApiService.post(
      '/posts/remove_post_like',
      data: {"post_id": postId},
    );

    return _handleResponse<LikeModel>(response, (data) {
      var likeData = jsonDecode(data['data']);
      return LikeModel(likeCount: likeData['LikeCount']);
    });
  }

  // Private method to handle API response
  Future<T> _handleResponse<T>(
      dynamic response, T Function(Map<String, dynamic>) parser) async {
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
          'Unexpected response: ${response.statusCode}, ${response.data}');
    }
  }
}
