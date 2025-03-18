import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/user/data/models/follow_un_follow_model.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

final class UnFollowUserParams {
  final int followingUserId;

  UnFollowUserParams({required this.followingUserId});
}

class UnFollowUserUseCase
    extends UseCase<DataState<FollowUnFollowModel>, UnFollowUserParams> {
  final UserProfileRepository repository;

  UnFollowUserUseCase(this.repository);

  @override
  Future<DataState<FollowUnFollowModel>> call({
    UnFollowUserParams? params,
  }) async {
    final followingCount = await repository.unFollowUser(
      params?.followingUserId ?? 0,
    );
    return followingCount;
  }
}
