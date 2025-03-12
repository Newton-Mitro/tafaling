import 'package:tafaling/features/user/data/models/follow_un_follow_model.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

class UnFollowUserUseCase {
  final UserProfileRepository repository;

  UnFollowUserUseCase(this.repository);

  Future<FollowUnFollowModel> call(int followingUserId) {
    return repository.unFollowUser(followingUserId);
  }
}
