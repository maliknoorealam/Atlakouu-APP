import 'dart:async';

import 'package:atalakou/screens/common/choose_profile.dart';
import 'package:atalakou/screens/common/on_boarding.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool onBoardingAppeared = false;

  @override
  void initState() {
    getOnBoardingInfo();
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => onBoardingAppeared
                ? const ChooseProfileType()
                : const OnBoardingPage()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: splashScreenNavyColor,
        body:
            Center(
          child: Container(
              margin: const EdgeInsets.only(top: 15,left: 30,right: 30),
              child: const Image(
                  image: AssetImage(
                      "assets/icons/splash_screen/atalakou-splash-screen-logo.jpg"),

              )),
        ));
  }

  getOnBoardingInfo() async {
    final prefs = await SharedPreferences.getInstance();
    onBoardingAppeared = prefs.getBool("onboarding") ?? false;
  }


}
