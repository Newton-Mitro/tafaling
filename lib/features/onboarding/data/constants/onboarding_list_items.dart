import 'package:tafaling/features/onboarding/data/models/onboarding_info.dart';

class OnboardingListItems {
  static List<OnboardingInfo> listItems = [
    OnboardingInfo(
      title: "Welcome to Tafaling!",
      description:
          "Connect with friends and share your moments like never before.",
      imagePath: "assets/images/onboarding/onboarding_one.webp",
    ),
    OnboardingInfo(
      title: "Create & Share Posts",
      description:
          "Express yourself with text, photos, and videos. Let the world see your story!",
      imagePath: "assets/images/onboarding/onboarding_two.webp",
    ),
    OnboardingInfo(
      title: "Find & Follow Friends",
      description: "Discover new people and build meaningful connections.",
      imagePath: "assets/images/onboarding/onboarding_three.png",
    ),
    OnboardingInfo(
      title: "Stay Updated",
      description:
          "Get real-time notifications on likes, comments, and messages.",
      imagePath: "assets/images/onboarding/onboarding_four.png",
    ),
  ];
}
