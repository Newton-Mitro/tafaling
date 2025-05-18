import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/entities/like_entity.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

final class LikePostPrams {
  final int postId;
  const LikePostPrams({required this.postId});
}

class LikePostUseCase extends UseCase<LikeEntity, LikePostPrams> {
  final PostRepository postRepository;

  LikePostUseCase({required this.postRepository});

  @override
  ResultFuture<LikeEntity> call(LikePostPrams? params) {
    return postRepository.likePost(params?.postId ?? 0);
  }
}
