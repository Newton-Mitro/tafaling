import 'package:tafaling/features/user/data/models/search_user_model.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

class SearchUsersUseCase {
  final UserProfileRepository repository;

  SearchUsersUseCase(this.repository);

  Future<List<SearchUserModel>> call(
      int userId, String searchText, int startRecord, int pageSize) {
    return repository.searchUsers(userId, searchText, startRecord, pageSize);
  }
}
