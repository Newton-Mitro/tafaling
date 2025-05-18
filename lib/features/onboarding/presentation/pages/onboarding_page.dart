import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/onboarding/data/models/onboarding_info.dart';
import 'package:tafaling/features/onboarding/presentation/bloc/onboarding_page_bloc.dart';
import 'package:tafaling/routes/route_name.dart';
import 'package:tafaling/shared/widgets/buttons/app_primary_button.dart';
import 'package:tafaling/shared/widgets/theme_selector/theme_selector.dart';

getOnboardingListItems(BuildContext context) {
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

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<OnboardingInfoModel> onboardingItems = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingPageBloc, OnboardingPageState>(
      listener: (context, state) {
        if (state is OnboardingSeenSetSuccess) {
          Navigator.popAndPushNamed(context, RoutesName.homePage);
        } else if (state is OnboardingError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                itemCount: onboardingItems.length,
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Image.asset(
                        onboardingItems[index].imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: const Color.fromARGB(169, 1, 0, 5),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 80,
                          horizontal: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              onboardingItems[index].title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              onboardingItems[index].description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              // Positioned(
              //   top: 16,
              //   left: 16,
              //   child: const SafeArea(child: LanguageSwitch()),
              // ),
              Positioned(
                top: 16,
                right: 16,
                child: const SafeArea(child: ThemeSelector()),
              ),

              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentPage > 0)
                        AppPrimaryButton(
                          label: Locales.string(
                            context,
                            'onboarding_previous_button',
                          ),
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          iconBefore: Icon(
                            Icons.arrow_back,
                            color: context.theme.colorScheme.onPrimary,
                          ),
                          horizontalPadding: 0,
                        )
                      else
                        const SizedBox(width: 88),

                      SmoothPageIndicator(
                        controller: _pageController,
                        count: onboardingItems.length,
                        effect: ExpandingDotsEffect(
                          dotColor: context.theme.colorScheme.primary,
                          activeDotColor: context.theme.colorScheme.error,
                          dotHeight: 10,
                          dotWidth: 10,
                          spacing: 5,
                        ),
                      ),

                      (currentPage == onboardingItems.length - 1)
                          ? AppPrimaryButton(
                            label: Locales.string(
                              context,
                              'onboarding_get_started_button',
                            ),
                            onPressed: () {
                              context.read<OnboardingPageBloc>().add(
                                SetOnboardingSeenEvent(seen: true),
                              );
                              Navigator.popAndPushNamed(
                                context,
                                RoutesName.homePage,
                              );
                            },
                            iconAfter: Icon(
                              Icons.rocket_launch,
                              color: context.theme.colorScheme.onPrimary,
                            ),
                            horizontalPadding: 0,
                          )
                          : AppPrimaryButton(
                            label: Locales.string(
                              context,
                              'onboarding_next_button',
                            ),
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                            iconAfter: Icon(
                              Icons.arrow_forward,
                              color: context.theme.colorScheme.onPrimary,
                            ),
                            horizontalPadding: 0,
                          ),
                    ],
                  ),
                ),
              ),
              if (state is OnboardingLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}
