import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/user/domain/entities/search_user_entity.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

final class SearchUsersParams {
  final int userId;
  final String searchText;
  final int startRecord;
  final int pageSize;

  SearchUsersParams({
    required this.userId,
    required this.searchText,
    required this.startRecord,
    required this.pageSize,
  });
}

class SearchUsersUseCase
    extends UseCase<DataState<List<SearchUserEntity>>, SearchUsersParams> {
  final UserProfileRepository repository;

  SearchUsersUseCase(this.repository);

  @override
  Future<DataState<List<SearchUserEntity>>> call({SearchUsersParams? params}) {
    return repository.searchUsers(
      params?.userId ?? 0,
      params?.searchText ?? '',
      params?.startRecord ?? 0,
      params?.pageSize ?? 10,
    );
  }
}
