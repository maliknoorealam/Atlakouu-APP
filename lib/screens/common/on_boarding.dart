import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/onboarding/dots.dart';
import 'package:atalakou/widgets/onboarding/next_button.dart';
import 'package:atalakou/widgets/onboarding/skip_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/onboarding/onboarding_content.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _currentPage < 2?
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SkipButton(),
              ],
            ) :const SizedBox(height: 65,),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: const [
                  OnBoardingContent(
                    imageName: "image_1.png",
                    description: onBoardingDescription1,
                  ),
                  OnBoardingContent(
                    imageName: "image_2.png",
                    description: onBoardingDescription2,
                  ),
                  OnBoardingContent(
                    imageName: "image_3.png",
                    description: onBoardingDescription3,
                  ),
                ],
              ),
            ),
            PageViewDots(currentPage: _currentPage),
            NextButton(currentPage: _currentPage,pageController: _pageController,),
          ],
        ),
      ),
    );
  }
}
