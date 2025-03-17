import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final NetworkService networkService;

  PostRepositoryImpl(this.remoteDataSource, this.networkService);

  @override
  Future<List<PostModel>> fetchPosts(
      int userId, int startRecord, int pageSize) async {
    if (await networkService.isConnected == true) {
      try {
        var posts =
            await remoteDataSource.fetchPosts(userId, startRecord, pageSize);

        return posts;
      } on ServerException {
        throw Exception('Server exception.');
      }
    } else {
      try {
        // TODO: Local data source impl
        // return remoteDataSource.fetchPosts(startRecord, startRecord);
      } on CacheException {
        throw Exception('No local data found');
      }
    }
    throw Exception('Server exception.');
  }

  @override
  Future<List<PostModel>> fetchUserPosts(
      int userId, int startRecord, int pageSize) async {
    if (await networkService.isConnected == true) {
      try {
        var posts = await remoteDataSource.fetchUserPosts(
            userId, startRecord, pageSize);

        return posts;
      } on ServerException {
        throw Exception('Server exception.');
      }
    } else {
      try {
        // TODO: Local data source impl
        // return remoteDataSource.fetchPosts(startRecord, startRecord);
      } on CacheException {
        throw Exception('No local data found');
      }
    }
    throw Exception('Server exception.');
  }

  @override
  Future<LikeModel> likePost(int postId) async {
    if (await networkService.isConnected == true) {
      try {
        return await remoteDataSource.likePost(postId);
      } on ServerException {
        throw Exception('Server exception.');
      }
    } else {
      try {
        // TODO: Local data source impl
        // return remoteDataSource.fetchPosts(startRecord, startRecord);
      } on CacheException {
        throw Exception('No local data found');
      }
    }
    throw Exception('Server exception.');
  }

  @override
  Future<LikeModel> disLikePost(int postId) async {
    if (await networkService.isConnected == true) {
      try {
        return await remoteDataSource.disLikePost(postId);
      } on ServerException {
        throw Exception('Server exception.');
      }
    } else {
      try {
        // TODO: Local data source impl
        // return remoteDataSource.fetchPosts(startRecord, startRecord);
      } on CacheException {
        throw Exception('No local data found');
      }
    }
    throw Exception('Server exception.');
  }
}
