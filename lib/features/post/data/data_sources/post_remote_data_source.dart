import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tafaling/core/network/api_service.dart';
import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

abstract class PostRemoteDataSource {
  Future<String> createPost(int privacyId, String body, List<File> attachments);
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

  Future<String> likePostComment(int commentId, int userId);
  Future<String> updatePostPrivacy(int privacyId, int postId, int userId);
  Future<String> updatePostComment(
    int commentId,
    String commentBody,
    int userId,
  );
  Future<String> sharePost(int privacyId, String body, int postId);
  Future<List<PostModel>> getUserSharedPosts(
    int postId,
    int userId,
    int startRecord,
    int pageSize,
  );
  Future<List<PostModel>> getUserPostComments(
    int postId,
    int userId,
    int parentCommentId,
    int startRecord,
    int pageSize,
  );
  Future<String> deletePostComment(int commentId, int userId);
  Future<String> removePostCommentLike(int commentId, int userId);
  Future<String> commentOnPost(
    int parentCommentId,
    String commentBody,
    int postId,
  );

  // Future<List<PrivacyModel>> getPrivacies();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final ApiService apiService;
  final ApiService authApiService;

  PostRemoteDataSourceImpl({
    required this.apiService,
    required this.authApiService,
  });

  @override
  Future<String> createPost(
    int privacyId,
    String body,
    List<File> attachments,
  ) async {
    try {
      final formData = FormData();

      formData.fields
        ..add(MapEntry('privacy_id', privacyId.toString()))
        ..add(MapEntry('body', body));

      for (int i = 0; i < attachments.length; i++) {
        final file = attachments[i];
        formData.files.add(
          MapEntry(
            'attachments[]',
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }

      final response = await authApiService.post(
        '/posts/create',
        data: formData,
      );

      if (response.statusCode == HttpStatus.created ||
          response.statusCode == HttpStatus.ok) {
        return response.data['data'] ?? 'Post created successfully';
      } else {
        throw Exception('Post creation failed');
      }
    } catch (e) {
      rethrow;
    }
  }

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
        final data = response.data['data'];
        return (data as List).map((post) => PostModel.fromJson(post)).toList();
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
        final data = response.data['data'];
        return (data as List).map((post) => PostModel.fromJson(post)).toList();
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
        final data = response.data['data'];
        return LikeModel.fromJson(data);
      } else {
        throw Exception('Like post failed');
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
        final data = response.data['data'];
        return LikeModel.fromJson(data);
      } else {
        throw Exception('Dislike post failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getLikeUserByPost(
    int postId,
    int startRecord,
    int pageSize,
  ) async {
    try {
      final response = await authApiService.get(
        '/posts/liked/users',
        queryParameters: {
          'post_id': postId,
          'start_record': startRecord,
          'page_size': pageSize,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['data'];
        return (data as List)
            .map((user) => UserModel.fromJsonForPostLikeUser(user))
            .toList();
      } else {
        throw Exception('Get like users failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> removePost(int postId) async {
    try {
      final response = await authApiService.post(
        '/posts/remove',
        data: {"post_id": postId},
      );

      if (response.statusCode == HttpStatus.ok) {
        return response.data['data'] ?? 'Post removed successfully';
      } else {
        throw Exception('Remove post failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> likePostComment(int commentId, int userId) async {
    try {
      final response = await authApiService.post(
        '/posts/add_post_comment_like',
        data: {"comment_id": commentId, "user_id": userId},
      );

      if (response.statusCode == HttpStatus.created) {
        return response.data['data'] ?? 'Comment liked successfully';
      } else {
        throw Exception('Like post comment failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updatePostPrivacy(
    int privacyId,
    int postId,
    int userId,
  ) async {
    try {
      final response = await authApiService.post(
        '/posts/update_post_privacy',
        data: {"privacy_id": privacyId, "post_id": postId, "user_id": userId},
      );

      if (response.statusCode == HttpStatus.ok) {
        return response.data['data'] ?? 'Post privacy updated successfully';
      } else {
        throw Exception('Update post privacy failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updatePostComment(
    int commentId,
    String commentBody,
    int userId,
  ) async {
    try {
      final response = await authApiService.post(
        '/posts/comment/update',
        data: {
          "comment_id": commentId,
          "comment_body": commentBody,
          "user_id": userId,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        return response.data['data'] ?? 'Comment updated successfully';
      } else {
        throw Exception('Update post comment failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> sharePost(int privacyId, String body, int postId) async {
    try {
      final response = await authApiService.post(
        '/posts/share',
        data: {"privacy_id": privacyId, "body": body, "post_id": postId},
      );

      if (response.statusCode == HttpStatus.created) {
        return response.data['data'] ?? 'Post shared successfully';
      } else {
        throw Exception('Share post failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PostModel>> getUserSharedPosts(
    int postId,
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    try {
      final response = await authApiService.get(
        '/posts/get/share/$postId',
        queryParameters: {
          'user_id': userId,
          'start_record': startRecord,
          'page_size': pageSize,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['data'];
        return (data as List).map((post) => PostModel.fromJson(post)).toList();
      } else {
        throw Exception('Get user shared posts failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PostModel>> getUserPostComments(
    int postId,
    int userId,
    int parentCommentId,
    int startRecord,
    int pageSize,
  ) async {
    try {
      final response = await authApiService.get(
        '/posts/get/comment/V2/$postId/$parentCommentId',
        queryParameters: {
          'user_id': userId,
          'start_record': startRecord,
          'page_size': pageSize,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['data'];
        return (data as List).map((post) => PostModel.fromJson(post)).toList();
      } else {
        throw Exception('Get user post comments failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deletePostComment(int commentId, int userId) async {
    try {
      final response = await authApiService.post(
        '/posts/comment/delete',
        data: {"comment_id": commentId, "user_id": userId},
      );

      if (response.statusCode == HttpStatus.ok) {
        return response.data['data'] ?? 'Comment deleted successfully';
      } else {
        throw Exception('Delete post comment failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> removePostCommentLike(int commentId, int userId) async {
    try {
      final response = await authApiService.post(
        '/posts/comment/like/delete',
        data: {"comment_id": commentId, "user_id": userId},
      );

      if (response.statusCode == HttpStatus.ok) {
        return response.data['data'] ?? 'Comment like removed successfully';
      } else {
        throw Exception('Remove post comment like failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> commentOnPost(
    int parentCommentId,
    String commentBody,
    int postId,
  ) async {
    try {
      final response = await authApiService.post(
        '/posts/comment',
        data: {
          "parent_comment_id": parentCommentId,
          "comment_body": commentBody,
          "post_id": postId,
        },
      );

      if (response.statusCode == HttpStatus.created) {
        return response.data['data'] ?? 'Comment posted successfully';
      } else {
        throw Exception('Comment on post failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<List<PrivacyModel>> getPrivacies() async {
  //   try {
  //     final response = await authApiService.get('/auth/get-privacy');

  //     if (response.statusCode == HttpStatus.ok) {
  //       final data = response.data['data'];
  //       return (data as List).map((privacy) => PrivacyModel.fromJson(privacy)).toList();
  //     } else {
  //       throw Exception('Get privacies failed');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
