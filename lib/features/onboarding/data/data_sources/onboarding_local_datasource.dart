import 'package:flutter/widgets.dart';
import 'package:tafaling/core/services/local_storage/local_storage.dart';
import 'package:tafaling/features/onboarding/data/models/onboarding_info.dart';

abstract class OnboardingLocalDataSource {
  Future<void> setOnboardingSeen(bool seen);
  Future<bool> hasSeenOnboarding();
  Future<List<OnboardingInfoModel>> getOnboardingInfos(BuildContext context);
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final LocalStorage localStorage;

  OnboardingLocalDataSourceImpl({required this.localStorage});

  static const _onboardingKey = 'onboarding_seen';

  @override
  Future<void> setOnboardingSeen(bool seen) async {
    await localStorage.saveBool(_onboardingKey, seen);
  }

  @override
  Future<bool> hasSeenOnboarding() async {
    return localStorage.getBool(_onboardingKey);
  }

  @override
  Future<List<OnboardingInfoModel>> getOnboardingInfos(
    BuildContext context,
  ) async {
    return [
      OnboardingInfoModel(
        title: "Connect, Share, and Discover Like Never Before",
        description:
            "Tafaling is your go-to platform for meaningful social interactions and creative self-expression. Share your moments, engage with a dynamic community, and explore endless content. Whether posting photos, sharing videos, or discovering new trends, Tafaling makes it effortless and enjoyable.",
        imagePath: "assets/images/onboarding/onboarding_one.jpg",
      ),
      OnboardingInfoModel(
        title: "Create & Share Posts with Ease",
        description:
            "Express yourself freely through text, images, and videos. Share your thoughts, showcase your creativity, and let the world be part of your story!",
        imagePath: "assets/images/onboarding/onboarding_two.jpg",
      ),
      OnboardingInfoModel(
        title: "Find & Connect with Friends",
        description:
            "Discover new people, follow your friends, and build lasting connections in a thriving community.",
        imagePath: "assets/images/onboarding/onboarding_three.jpg",
      ),
      OnboardingInfoModel(
        title: "Get Started with Tafaling Today!",
        description:
            "Joining Tafaling is quick and effortless! Simply sign up for free, personalize your profile, and start exploring a vibrant world of connections. Share your moments, engage with others, and experience social networking like never before!",
        imagePath: "assets/images/onboarding/onboarding_four.jpg",
      ),
      // OnboardingInfoModel(
      //   title: Locales.string(context, 'onboarding_title_1'),
      //   description: Locales.string(context, 'onboarding_description_1'),
      //   imagePath: AppImages.pathOnboarding1,
      // ),
      // OnboardingInfoModel(
      //   title: Locales.string(context, 'onboarding_title_2'),
      //   description: Locales.string(context, 'onboarding_description_2'),
      //   imagePath: AppImages.pathOnboarding2,
      // ),
      // OnboardingInfoModel(
      //   title: Locales.string(context, 'onboarding_title_3'),
      //   description: Locales.string(context, 'onboarding_description_3'),
      //   imagePath: AppImages.pathOnboarding3,
      // ),
      // OnboardingInfoModel(
      //   title: Locales.string(context, 'onboarding_title_4'),
      //   description: Locales.string(context, 'onboarding_description_4'),
      //   imagePath: AppImages.pathOnboarding4,
      // ),
    ];
  }
}
