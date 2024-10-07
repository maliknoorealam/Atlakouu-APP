import 'package:flutter/material.dart';

import '../../routes/routes.dart';
import '../../utils/constants.dart';
import '../../utils/shared_pref.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setOnBoardingToTrue();
        Navigator.of(context).pushReplacementNamed(AppRouter.chooseProfileType);      },
      child: Container(
          margin: const EdgeInsets.only(right: 20,top: 30),
          height: 35,
          width: 60,
          decoration: BoxDecoration(
              color: goldColor,
              borderRadius: BorderRadius.circular(30)),
          child: const Center(
            child: Text(
              "Passer",
              style: TextStyle(
                color: navyColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          )),
    );
  }
}
