import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class SharePostParams {
  final int privacyId;
  final String body;
  final int postId;

  SharePostParams({
    required this.privacyId,
    required this.body,
    required this.postId,
  });
}

class SharePostUseCase implements UseCase<String, SharePostParams> {
  final PostRepository repository;

  SharePostUseCase(this.repository);

  @override
  ResultFuture<String> call(SharePostParams params) {
    return repository.sharePost(params.privacyId, params.body, params.postId);
  }
}
