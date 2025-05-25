import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class RemovePostCommentLikeParams {
  final int commentId;
  final int userId;

  RemovePostCommentLikeParams({required this.commentId, required this.userId});
}

class RemovePostCommentLikeUseCase
    implements UseCase<String, RemovePostCommentLikeParams> {
  final PostRepository repository;

  RemovePostCommentLikeUseCase(this.repository);

  @override
  ResultFuture<String> call(RemovePostCommentLikeParams params) {
    return repository.removePostCommentLike(params.commentId, params.userId);
  }
}
