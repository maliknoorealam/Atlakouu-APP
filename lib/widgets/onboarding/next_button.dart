import 'package:atalakou/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../../routes/routes.dart';
import '../../utils/constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.currentPage, required this.pageController});

  final int currentPage;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  GestureDetector(
      onTap: () {
      if (currentPage < 2) {
    pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        setOnBoardingToTrue();
        Navigator.of(context).pushReplacementNamed(AppRouter.chooseProfileType);
      }
    },
      child: Container(
        margin: EdgeInsets.only(top: size.height/15,bottom: size.height/14.5),
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: navyColor
        ),
        child: const Icon(
          Icons.arrow_forward_ios,
          color: whiteColor,
        ),
      ),
    );
  }
}
