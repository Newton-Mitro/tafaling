import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

final class GetFollowingUsersParams {
  final int targetUserId;
  final int startRecord;
  final int pageSize;

  GetFollowingUsersParams({
    required this.targetUserId,
    required this.startRecord,
    required this.pageSize,
  });
}

class GetFollowingUsersUseCase
    extends UseCase<List<UserEntity>, GetFollowingUsersParams> {
  final UserRepository userRepository;

  GetFollowingUsersUseCase({required this.userRepository});

  @override
  ResultFuture<List<UserEntity>> call(GetFollowingUsersParams? params) {
    return userRepository.getFollowingUsers(
      params?.targetUserId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 10,
    );
  }
}
