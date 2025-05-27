import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class CommentOnPostParams {
  final int parentCommentId;
  final String commentBody;
  final int postId;

  CommentOnPostParams({
    required this.parentCommentId,
    required this.commentBody,
    required this.postId,
  });
}

class CommentOnPostUseCase implements UseCase<String, CommentOnPostParams> {
  final PostRepository repository;

  CommentOnPostUseCase({required this.repository});

  @override
  ResultFuture<String> call(CommentOnPostParams params) {
    return repository.commentOnPost(
      params.parentCommentId,
      params.commentBody,
      params.postId,
    );
  }
}
