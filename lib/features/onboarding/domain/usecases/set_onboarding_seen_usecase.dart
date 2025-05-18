import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/onboarding/domain/repositories/onboarding_info_repository.dart';

final class SetOnboardingSeenParams {
  final bool seen;

  SetOnboardingSeenParams({required this.seen});
}

class SetOnboardingSeenUseCase extends UseCase<void, SetOnboardingSeenParams> {
  final OnboardingInfoRepository repository;

  SetOnboardingSeenUseCase({required this.repository});

  @override
  ResultFuture call(SetOnboardingSeenParams? params) {
    return repository.setOnboardingSeen(params!.seen);
  }
}
