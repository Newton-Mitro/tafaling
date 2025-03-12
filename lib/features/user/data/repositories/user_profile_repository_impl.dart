import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/network_old/network_info.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/data/data_sources/user_profile_remote_data_source.dart';
import 'package:tafaling/features/user/data/models/follow_un_follow_model.dart';
import 'package:tafaling/features/user/data/models/search_user_model.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;
  final NetworkService networkService;

  UserProfileRepositoryImpl(this.remoteDataSource, this.networkService);

  @override
  Future<FollowUnFollowModel> followUser(int followingUserId) async {
    if (await networkService.isConnected == true) {
      try {
        return await remoteDataSource.followUser(followingUserId);
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
  Future<FollowUnFollowModel> unFollowUser(int followingUserId) async {
    if (await networkService.isConnected == true) {
      try {
        return await remoteDataSource.unFollowUser(followingUserId);
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
  Future<List<PostModel>> fetchProfile(
      int userId, int startRecord, int pageSize) async {
    if (await networkService.isConnected == true) {
      try {
        var posts =
            await remoteDataSource.fetchProfile(userId, startRecord, pageSize);

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
  Future<List<SearchUserModel>> searchUsers(
      int userId, String searchText, int startRecord, int pageSize) async {
    if (await networkService.isConnected == true) {
      try {
        var users = await remoteDataSource.searchUsers(
            userId, searchText, startRecord, pageSize);

        return users;
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
