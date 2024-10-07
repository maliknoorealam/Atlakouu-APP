import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bottomnavigation/lfs_main_navigation.dart';
import '../../../utils/constants.dart';

bottomNavigationLFS(BuildContext context, int current) {
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/vectors/common/icon_home_nav.svg",
          height: 24,
        ),
        label: home,
      ),
      const BottomNavigationBarItem(
        icon: Image(
          image: AssetImage(
              "assets/icons/looking_for_services/navigation_bar/icon_fav_nav.png"),
          height: 20,
        ),
        label: favorites,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/vectors/common/icon_profile_nav.svg",
          height: 24,
        ),
        label: profile,
      ),
    ],
    currentIndex: current,
    selectedItemColor: goldColor,
    unselectedItemColor: navyColor,
    onTap: (index) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LFSMainScreen(startingIndex: index)),
      );
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => NavigationPage(startingIndex: index)),
      //       (Route<dynamic> route) =>
      //   route.settings.name == AppRouter.splashScreen ||
      //       route.settings.name == AppRouter.chooseProfileType,
      // );
    },
  );
}
