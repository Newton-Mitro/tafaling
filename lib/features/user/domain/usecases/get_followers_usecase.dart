import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

final class GetFollowersParams {
  final int targetUserId;
  final int startRecord;
  final int pageSize;

  GetFollowersParams({
    required this.targetUserId,
    required this.startRecord,
    required this.pageSize,
  });
}

class GetFollowersUseCase
    extends UseCase<List<UserEntity>, GetFollowersParams> {
  final UserRepository userRepository;

  GetFollowersUseCase({required this.userRepository});

  @override
  ResultFuture<List<UserEntity>> call(GetFollowersParams? params) {
    return userRepository.getFollowers(
      params?.targetUserId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 10,
    );
  }
}
