import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class GetUserPostCommentsParams {
  final int postId;
  final int userId;
  final int parentCommentId;
  final int startRecord;
  final int pageSize;

  GetUserPostCommentsParams({
    required this.postId,
    required this.userId,
    required this.parentCommentId,
    required this.startRecord,
    required this.pageSize,
  });
}

class GetUserPostCommentsUseCase
    implements UseCase<List<PostEntity>, GetUserPostCommentsParams> {
  final PostRepository repository;

  GetUserPostCommentsUseCase(this.repository);

  @override
  ResultFuture<List<PostEntity>> call(GetUserPostCommentsParams params) {
    return repository.getUserPostComments(
      params.postId,
      params.userId,
      params.parentCommentId,
      params.startRecord,
      params.pageSize,
    );
  }
}
