import 'package:atalakou/authentication/auth_stream.dart';
import 'package:atalakou/screens/lookingforjob/lfj_homepage.dart';
import 'package:atalakou/screens/lookingforjob/messages_page.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/lookingforjob/profile_page.dart';

class LFJMainScreen extends StatefulWidget {
  const LFJMainScreen({super.key, required this.startingIndex});

  @override
  State<LFJMainScreen> createState() => _LFJMainScreenState();
  final int startingIndex;
}

class _LFJMainScreenState extends State<LFJMainScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.startingIndex;
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(
        index,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          LFJHomePage(),
          MessagesPage(),
          AuthPage(screen: ProfilePage()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: goldColor,
        unselectedItemColor: navyColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
