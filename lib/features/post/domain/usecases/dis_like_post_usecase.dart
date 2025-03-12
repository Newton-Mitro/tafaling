import 'package:tafaling/features/post/data/models/like_model.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class DisLikePostUseCase {
  final PostRepository repository;

  DisLikePostUseCase(this.repository);

  Future<LikeModel> call(int postId) {
    return repository.disLikePost(postId);
  }
}
