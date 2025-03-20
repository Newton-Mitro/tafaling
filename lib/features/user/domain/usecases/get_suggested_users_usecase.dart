import 'package:tafaling/core/resources/response_state.dart';
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
    extends UseCase<DataState<List<UserEntity>>, GetSuggestedUsersParams> {
  final UserRepository repository;

  GetSuggestedUsersUseCase(this.repository);

  @override
  Future<DataState<List<UserEntity>>> call({GetSuggestedUsersParams? params}) {
    return repository.getSuggestedUsers(
      params?.userId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 10,
    );
  }
}
