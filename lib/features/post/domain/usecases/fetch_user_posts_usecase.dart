import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class FetchUserPostsUseCase {
  final PostRepository repository;

  FetchUserPostsUseCase(this.repository);

  Future<List<PostModel>> call(int userId, int startRecord, int pageSize) {
    return repository.fetchUserPosts(userId, startRecord, pageSize);
  }
}
