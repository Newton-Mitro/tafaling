import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class UpdatePostPrivacyParams {
  final int privacyId;
  final int postId;
  final int userId;

  UpdatePostPrivacyParams({
    required this.privacyId,
    required this.postId,
    required this.userId,
  });
}

class UpdatePostPrivacyUseCase
    implements UseCase<String, UpdatePostPrivacyParams> {
  final PostRepository repository;

  UpdatePostPrivacyUseCase(this.repository);

  @override
  ResultFuture<String> call(UpdatePostPrivacyParams params) {
    return repository.updatePostPrivacy(
      params.privacyId,
      params.postId,
      params.userId,
    );
  }
}
