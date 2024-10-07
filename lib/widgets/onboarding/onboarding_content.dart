import 'package:flutter/material.dart';

import 'circle_avatar.dart';
import 'onboarding_text.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({super.key, required this.imageName, required this.description});

  final String imageName;
  final String description;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CirclePicture(imageName: imageName),
        SizedBox(height: size.height/16.5,),
        OnBoardText(description: description),
      ],
    );
  }
}
