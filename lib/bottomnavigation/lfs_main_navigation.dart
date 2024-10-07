import 'package:atalakou/authentication/auth_stream.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/lookingforservices/fav_service.dart';
import '../screens/lookingforservices/service_main.dart';
import '../screens/lookingforservices/service_profile.dart';

class LFSMainScreen extends StatefulWidget {
  const LFSMainScreen({super.key, required this.startingIndex});

  @override
  State<LFSMainScreen> createState() => _LFSMainScreenState();
  final int startingIndex;
}

class _LFSMainScreenState extends State<LFSMainScreen> {
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
    return buildPageWithBottomNavigation(
      currentIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
      pageController: _pageController,
      children: [
        const ServiceMain(),
        const FavScreen(),
        const AuthPage(screen: ServiceProfile()),
      ],
    );
  }

  Widget buildPageWithBottomNavigation({
    required int currentIndex,
    required void Function(int) onItemTapped,
    required PageController pageController,
    required List<Widget> children,
  }) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/vectors/common/icon_home_nav.svg",height: 24,),
            label: home,
          ),
          const BottomNavigationBarItem(
            icon: Image(image: AssetImage("assets/icons/looking_for_services/navigation_bar/icon_fav_nav.png"),height: 20,),
            label: favorites,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/vectors/common/icon_profile_nav.svg",height: 24,),
            label: profile,
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: goldColor,
        unselectedItemColor: navyColor,
        onTap: onItemTapped,
      ),
    );
  }
}
