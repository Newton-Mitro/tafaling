// import 'package:tafaling/core/errors/exceptions.dart';
// import 'package:tafaling/core/network_old/network_info.dart';
// import 'package:tafaling/core/resources/response_state.dart';
// import 'package:tafaling/features/post/data/data_sources/post_remote_data_source.dart';
// import 'package:tafaling/features/post/data/models/like_model.dart';
// import 'package:tafaling/features/post/data/models/post_model.dart';
// import 'package:tafaling/features/post/domain/entities/post_entity.dart';
// import 'package:tafaling/features/post/domain/repositories/Xpost_repository.dart';

// class XPostRepositoryImpl implements XPostRepository {
//   final PostRemoteDataSource remoteDataSource;
//   final NetworkService networkService;

//   XPostRepositoryImpl(this.remoteDataSource, this.networkService);

//   @override
//   Future<ResponseState<List<PostModel>>> getPosts(
//       int userId, int startRecord, int pageSize) async {
//     if (await networkService.isConnected == true) {
//       try {
//         var posts =
//             await remoteDataSource.fetchPosts(userId, startRecord, pageSize);

//         return posts;
//       } on ServerException {
//         throw Exception('Server exception.');
//       }
//     } else {
//       try {} on CacheException {
//         throw Exception('No local data found');
//       }
//     }
//   }

//   @override
//   Future<ResponseState<LikeModel>> disLikePost(int postId) {
//     // TODO: implement disLikePost
//     throw UnimplementedError();
//   }

//   @override
//   Future<ResponseState<List<PostEntity>>> getUserPosts(
//       int userId, int startRecord, int pageSize) {
//     // TODO: implement getUserPosts
//     throw UnimplementedError();
//   }

//   @override
//   Future<ResponseState<LikeModel>> likePost(int postId) {
//     // TODO: implement likePost
//     throw UnimplementedError();
//   }
// }
