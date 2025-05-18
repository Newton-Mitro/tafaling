import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

final class FetchPostsPrams {
  final int userId;
  final int startRecord;
  final int pageSize;
  const FetchPostsPrams({
    required this.userId,
    required this.startRecord,
    required this.pageSize,
  });
}

class FetchPostsUseCase extends UseCase<List<PostEntity>, FetchPostsPrams> {
  final PostRepository postRepository;

  FetchPostsUseCase({required this.postRepository});

  @override
  ResultFuture<List<PostEntity>> call(FetchPostsPrams? params) {
    return postRepository.fetchPosts(
      params?.userId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 0,
    );
  }
}
