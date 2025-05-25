import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/post/domain/entities/privacy_entity.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';

class GetPrivaciesUseCase implements UseCase<List<PrivacyEntity>, NoParams> {
  final PostRepository repository;

  GetPrivaciesUseCase(this.repository);

  @override
  ResultFuture<List<PrivacyEntity>> call(NoParams params) {
    return repository.getPrivacies();
  }
}
