import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
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
    extends UseCase<List<UserEntity>, FetchProfileParams> {
  final UserRepository userRepository;

  FetchProfileUseCase({required this.userRepository});

  @override
  ResultFuture<List<UserEntity>> call(FetchProfileParams? params) async {
    final userProfile = await userRepository.fetchProfile(
      params?.userId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 10,
    );
    return userProfile;
  }
}
