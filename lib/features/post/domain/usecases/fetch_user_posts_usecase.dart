import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

final class FetchUserPostsPrams {
  final int userId;
  final int startRecord;
  final int pageSize;
  const FetchUserPostsPrams({
    required this.userId,
    required this.startRecord,
    required this.pageSize,
  });
}

class FetchUserPostsUseCase
    extends UseCase<DataState<List<PostEntity>>, FetchUserPostsPrams> {
  final PostRepository postRepository;

  FetchUserPostsUseCase({required this.postRepository});

  @override
  Future<DataState<List<PostEntity>>> call({FetchUserPostsPrams? params}) {
    return postRepository.fetchUserPosts(
      params?.userId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 0,
    );
  }
}
