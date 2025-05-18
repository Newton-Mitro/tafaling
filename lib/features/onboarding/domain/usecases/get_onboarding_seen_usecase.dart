import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/onboarding/domain/repositories/onboarding_info_repository.dart';

class GetOnboardingSeenUseCase extends UseCase<bool, NoParams> {
  final OnboardingInfoRepository repository;

  GetOnboardingSeenUseCase({required this.repository});

  @override
  ResultFuture<bool> call(NoParams params) async {
    return repository.getOnboardingSeen();
  }
}
