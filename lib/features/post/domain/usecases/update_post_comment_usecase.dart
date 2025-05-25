import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class UpdatePostCommentParams {
  final int commentId;
  final String commentBody;
  final int userId;

  UpdatePostCommentParams({
    required this.commentId,
    required this.commentBody,
    required this.userId,
  });
}

class UpdatePostCommentUseCase
    implements UseCase<String, UpdatePostCommentParams> {
  final PostRepository repository;

  UpdatePostCommentUseCase(this.repository);

  @override
  ResultFuture<String> call(UpdatePostCommentParams params) {
    return repository.updatePostComment(
      params.commentId,
      params.commentBody,
      params.userId,
    );
  }
}
