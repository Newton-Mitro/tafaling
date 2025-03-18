import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/user/data/models/follow_un_follow_model.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

final class FollowUserParams {
  final int followingUserId;

  FollowUserParams({required this.followingUserId});
}

class FollowUserUseCase
    extends UseCase<DataState<FollowUnFollowModel>, FollowUserParams> {
  final UserProfileRepository repository;

  FollowUserUseCase(this.repository);

  @override
  Future<DataState<FollowUnFollowModel>> call({
    FollowUserParams? params,
  }) async {
    final followingCount = repository.followUser(params?.followingUserId ?? 0);
    return followingCount;
  }
}
