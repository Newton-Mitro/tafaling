import 'package:tafaling/features/user/data/models/follow_un_follow_model.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

class FollowUserUseCase {
  final UserProfileRepository repository;

  FollowUserUseCase(this.repository);

  Future<FollowUnFollowModel> call(int followingUserId) {
    return repository.followUser(followingUserId);
  }
}
