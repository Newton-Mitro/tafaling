import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';

abstract class XPostRepository {
  Future<ResponseState<List<PostEntity>>> getPosts();
}
