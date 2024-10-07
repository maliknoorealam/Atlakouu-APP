
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';
import '../../bottomnavigation/ib_main_navigation.dart';

bottomNavigationIB(BuildContext context){
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: SvgPicture.asset("assets/vectors/common/icon_home_nav.svg",height: 24,),
        activeIcon: SvgPicture.asset("assets/vectors/common/icon_home_selected.svg",height: 24,),
        label: home,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset("assets/vectors/looking_for_job/icon_messages_nav.svg",height: 24,),
        activeIcon: SvgPicture.asset("assets/vectors/looking_for_job/icon_messages_selected.svg",height: 24,),
        label: messages,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset("assets/vectors/common/icon_profile_nav.svg",height: 24,),
        activeIcon: SvgPicture.asset("assets/vectors/common/icon_profile_selected_nav.svg",height: 24,),
        label: profile,
      ),
    ],
    currentIndex: 0,
    selectedItemColor: goldColor,
    unselectedItemColor: navyColor,
    onTap: (index) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IBMainScreen(startingIndex: index)));
    },
  );
}