import 'package:flutter_skeleton/features/onboarding/data/models/onboarding_info.dart';

class OnboardingListItems {
  static List<OnboardingInfo> listItems = [
    OnboardingInfo(
      title: "Welcome to Flutter Skeleton",
      description: "This is a skeleton project for Flutter.",
      imagePath: "assets/images/onboarding/onboarding_one.png",
    ),
    OnboardingInfo(
      title: "Onboarding Page",
      description: "This is the onboarding page.",
      imagePath: "assets/images/onboarding/onboarding_two.png",
    ),
  ];
}
