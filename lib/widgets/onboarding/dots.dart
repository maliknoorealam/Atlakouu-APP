import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';

class PageViewDots extends StatelessWidget {
  const PageViewDots({super.key, required this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(3, (int index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(right: 5.0),
          height: 6.0,
          width: currentPage == index ? 24.0 : 6.0,
          decoration: BoxDecoration(
            color: currentPage == index ? navyColor : goldColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
        );
      }),
    );
  }
}
