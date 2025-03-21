import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

final class GetPostLikedUsersPrams {
  final int postId;
  final int startRecord;
  final int pageSize;
  const GetPostLikedUsersPrams({
    required this.postId,
    required this.startRecord,
    required this.pageSize,
  });
}

class GetPostLikedUsersUsecase
    extends UseCase<DataState<List<UserEntity>>, GetPostLikedUsersPrams> {
  final PostRepository postRepository;

  GetPostLikedUsersUsecase({required this.postRepository});

  @override
  Future<DataState<List<UserEntity>>> call({GetPostLikedUsersPrams? params}) {
    return postRepository.getLikeUserByPost(
      params?.postId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 0,
    );
  }
}
