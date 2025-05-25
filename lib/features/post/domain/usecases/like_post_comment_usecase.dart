import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class LikePostCommentParams {
  final int commentId;
  final int userId;

  LikePostCommentParams({required this.commentId, required this.userId});
}

class LikePostCommentUseCase implements UseCase<String, LikePostCommentParams> {
  final PostRepository repository;

  LikePostCommentUseCase(this.repository);

  @override
  ResultFuture<String> call(LikePostCommentParams params) {
    return repository.likePostComment(params.commentId, params.userId);
  }
}
