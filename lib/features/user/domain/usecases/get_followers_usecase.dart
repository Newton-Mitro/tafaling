import 'package:tafaling/core/resources/response_state.dart';
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
    extends UseCase<DataState<List<UserEntity>>, GetFollowersParams> {
  final UserProfileRepository repository;

  GetFollowersUseCase(this.repository);

  @override
  Future<DataState<List<UserEntity>>> call({GetFollowersParams? params}) {
    return repository.getFollowers(
      params?.targetUserId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 10,
    );
  }
}
