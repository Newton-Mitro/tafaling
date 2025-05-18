import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/user/domain/entities/follow_unfollow_entity.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

final class FollowUserParams {
  final int followingUserId;

  FollowUserParams({required this.followingUserId});
}

class FollowUserUseCase
    extends UseCase<FollowUnFollowEntity, FollowUserParams> {
  final UserRepository userRepository;

  FollowUserUseCase({required this.userRepository});

  @override
  ResultFuture<FollowUnFollowEntity> call(FollowUserParams? params) async {
    final followingCount = userRepository.followUser(
      params?.followingUserId ?? 0,
    );
    return followingCount;
  }
}
