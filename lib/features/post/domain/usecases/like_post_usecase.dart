import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/entities/like_entity.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

final class LikePostPrams {
  final int postId;
  const LikePostPrams({required this.postId});
}

class LikePostUseCase extends UseCase<DataState<LikeEntity>, LikePostPrams> {
  final PostRepository repository;

  LikePostUseCase(this.repository);

  @override
  Future<DataState<LikeEntity>> call({LikePostPrams? params}) {
    return repository.likePost(params?.postId ?? 0);
  }
}
