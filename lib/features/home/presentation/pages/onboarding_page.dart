import 'package:flutter/material.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/home/data/constants/onboarding_list_items.dart';
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
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      OnboardingListItems.listItems[index].title,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      OnboardingListItems.listItems[index].description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 50),
                    isLastPage
                        ? getStartedButton(context)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if ((_pageController.page ?? 0).round() > 0) {
                                    _pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 300),
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
                                      OnboardingListItems.listItems.length -
                                          1) {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  }
                                },
                                child: const Text('Next'),
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
  return ElevatedButton(
    onPressed: () {
      AppSharedPref.setOnboardingStatus(false);
      Navigator.popAndPushNamed(context, RoutesName.homePage);
    },
    child: const Text('Get Started'),
  );
}
