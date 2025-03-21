import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/entities/like_entity.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

final class DisLikePostPrams {
  final int postId;
  const DisLikePostPrams({required this.postId});
}

class DisLikePostUseCase
    extends UseCase<DataState<LikeEntity>, DisLikePostPrams> {
  final PostRepository postRepository;

  DisLikePostUseCase({required this.postRepository});

  @override
  Future<DataState<LikeEntity>> call({DisLikePostPrams? params}) {
    return postRepository.disLikePost(params?.postId ?? 0);
  }
}
