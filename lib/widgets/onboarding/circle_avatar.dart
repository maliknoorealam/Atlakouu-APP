import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class CirclePicture extends StatelessWidget {
  const CirclePicture({super.key, required this.imageName});

  final String imageName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: size.height/2.35,
        width: size.width,
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        // color: Colors.green,
        child: CircleAvatar(
          backgroundColor: goldColor,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: size.height/2.35 - 25,
            width: size.width < 420? size.width - 40: 395,
            // color: Colors.red,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/onboarding/$imageName"),
            ),
          ),
        ),
      ),
    );
  }
}
