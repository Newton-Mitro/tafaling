import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class GetUserSharedPostsParams {
  final int postId;
  final int userId;
  final int startRecord;
  final int pageSize;

  GetUserSharedPostsParams({
    required this.postId,
    required this.userId,
    required this.startRecord,
    required this.pageSize,
  });
}

class GetUserSharedPostsUseCase
    implements UseCase<List<PostEntity>, GetUserSharedPostsParams> {
  final PostRepository repository;

  GetUserSharedPostsUseCase(this.repository);

  @override
  ResultFuture<List<PostEntity>> call(GetUserSharedPostsParams params) {
    return repository.getUserSharedPosts(
      params.postId,
      params.userId,
      params.startRecord,
      params.pageSize,
    );
  }
}
