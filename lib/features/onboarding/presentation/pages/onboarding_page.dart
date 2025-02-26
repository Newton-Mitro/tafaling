import 'package:flutter/material.dart';
import 'package:flutter_skeleton/core/constants/route_name.dart';
import 'package:flutter_skeleton/core/utils/app_shared_pref.dart';
import 'package:flutter_skeleton/features/onboarding/data/constants/onboarding_list_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: isLastPage
            ? getStartedButton(context)
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if ((_pageController.page ?? 0).round() > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: const Text('Previous'),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: OnboardingListItems.listItems.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blue,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if ((_pageController.page ?? 0).round() <
                          OnboardingListItems.listItems.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
      ),
      body: PageView.builder(
        itemCount: OnboardingListItems.listItems.length,
        onPageChanged: (value) => setState(() {
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      OnboardingListItems.listItems[index].title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      OnboardingListItems.listItems[index].description,
                      textAlign: TextAlign.center,
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
  return ElevatedButton(
    onPressed: () {
      AppSharedPref.setOnboardingStatus(false);
      Navigator.pushNamed(context, RoutesName.homeScreen);
    },
    child: const Text('Get Started'),
  );
}
