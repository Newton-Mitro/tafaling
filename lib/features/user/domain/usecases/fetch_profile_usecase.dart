import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

class FetchProfileUseCase {
  final UserProfileRepository repository;

  FetchProfileUseCase(this.repository);

  Future<List<PostModel>> call(int userId, int startRecord, int pageSize) {
    return repository.fetchProfile(userId, startRecord, pageSize);
  }
}
