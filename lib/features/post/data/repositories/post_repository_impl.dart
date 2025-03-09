import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  @override
  Future<ResponseState<List<PostModel>>> getPosts() {
    throw UnimplementedError();
  }
}
