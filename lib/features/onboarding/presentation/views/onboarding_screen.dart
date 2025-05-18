import 'package:flutter/material.dart';
import 'package:tafaling/routes/route_name.dart';
import 'package:tafaling/core/constants/constants.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/core/services/local_storage/local_storage.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/home/data/constants/onboarding_list_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: OnboardingListItems.listItems.length,
        onPageChanged:
            (value) => setState(() {
              isLastPage = value == OnboardingListItems.listItems.length - 1;
            }),
        controller: _pageController,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                OnboardingListItems.listItems[index].imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color.fromARGB(80, 0, 0, 0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      OnboardingListItems.listItems[index].title,
                      style: context.theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      OnboardingListItems.listItems[index].description,
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 50),
                    isLastPage
                        ? getStartedButton(context)
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FilledButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                  context.theme.colorScheme.primary,
                                ),
                                foregroundColor: WidgetStatePropertyAll<Color>(
                                  context.theme.colorScheme.onPrimary,
                                ),
                              ),
                              onPressed: () {
                                if ((_pageController.page ?? 0).round() > 0) {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                              child: Text(
                                'Previous',
                                style: context.theme.textTheme.labelSmall,
                              ),
                            ),
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: OnboardingListItems.listItems.length,
                              effect: ExpandingDotsEffect(
                                dotColor: context.theme.colorScheme.primary,
                                activeDotColor: context.theme.colorScheme.error,
                                dotHeight: 10,
                                dotWidth: 10,
                                spacing: 5,
                              ),
                            ),
                            FilledButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                  context.theme.colorScheme.primary,
                                ),
                                foregroundColor: WidgetStatePropertyAll<Color>(
                                  context.theme.colorScheme.onPrimary,
                                ),
                              ),
                              onPressed: () {
                                if ((_pageController.page ?? 0).round() <
                                    OnboardingListItems.listItems.length - 1) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                              child: Text(
                                'Next',
                                style: context.theme.textTheme.labelSmall,
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget getStartedButton(BuildContext context) {
  return FilledButton(
    style: FilledButton.styleFrom(
      backgroundColor: context.theme.colorScheme.primary,
      foregroundColor: context.theme.colorScheme.onPrimary,
    ),
    onPressed: () {
      final localStorage = sl<LocalStorage>();
      localStorage.saveBool(Constants.onboardingKey, false);
      Navigator.popAndPushNamed(context, RoutesName.homePage);
    },
    child: Text('Get Started', style: context.theme.textTheme.labelSmall),
  );
}
