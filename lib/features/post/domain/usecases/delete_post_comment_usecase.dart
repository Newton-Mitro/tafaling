import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class DeletePostCommentParams {
  final int commentId;
  final int userId;

  DeletePostCommentParams({required this.commentId, required this.userId});
}

class DeletePostCommentUseCase
    implements UseCase<String, DeletePostCommentParams> {
  final PostRepository repository;

  DeletePostCommentUseCase(this.repository);

  @override
  ResultFuture<String> call(DeletePostCommentParams params) {
    return repository.deletePostComment(params.commentId, params.userId);
  }
}
