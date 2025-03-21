import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/user/domain/entities/follow_unfollow_entity.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

final class UnFollowUserParams {
  final int followingUserId;

  UnFollowUserParams({required this.followingUserId});
}

class UnFollowUserUseCase
    extends UseCase<DataState<FollowUnFollowEntity>, UnFollowUserParams> {
  final UserRepository userRepository;

  UnFollowUserUseCase({required this.userRepository});

  @override
  Future<DataState<FollowUnFollowEntity>> call({
    UnFollowUserParams? params,
  }) async {
    final followingCount = await userRepository.unFollowUser(
      params?.followingUserId ?? 0,
    );
    return followingCount;
  }
}
