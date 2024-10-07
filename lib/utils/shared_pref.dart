import 'package:shared_preferences/shared_preferences.dart';

setOnBoardingToTrue () async {
  final pref = await SharedPreferences.getInstance();
  pref.setBool("onboarding", true);
}