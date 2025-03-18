import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';

final class FetchProfileParams {
  final int userId;
  final int startRecord;
  final int pageSize;

  FetchProfileParams({
    required this.userId,
    required this.startRecord,
    required this.pageSize,
  });
}

class FetchProfileUseCase
    extends UseCase<DataState<List<PostModel>>, FetchProfileParams> {
  final UserProfileRepository repository;

  FetchProfileUseCase(this.repository);

  @override
  Future<DataState<List<PostModel>>> call({FetchProfileParams? params}) async {
    final userProfile = await repository.fetchProfile(
      params?.userId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 10,
    );
    return userProfile;
  }
}
