import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

final class GetSuggestedUsersParams {
  final int userId;
  final int startRecord;
  final int pageSize;

  GetSuggestedUsersParams({
    required this.userId,
    required this.startRecord,
    required this.pageSize,
  });
}

class GetSuggestedUsersUseCase
    extends UseCase<List<UserEntity>, GetSuggestedUsersParams> {
  final UserRepository userRepository;

  GetSuggestedUsersUseCase({required this.userRepository});

  @override
  ResultFuture<List<UserEntity>> call(GetSuggestedUsersParams? params) {
    return userRepository.getSuggestedUsers(
      params?.userId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 10,
    );
  }
}
