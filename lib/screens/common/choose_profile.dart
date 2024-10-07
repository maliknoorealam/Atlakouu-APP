import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bottomnavigation/ib_main_navigation.dart';
import '../../bottomnavigation/lfj_main_navigation.dart';
import '../../bottomnavigation/lfs_main_navigation.dart';


class ChooseProfileType extends StatelessWidget {
  const ChooseProfileType({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          chooseProfileAppBarTitle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileContainer(
              color: navyColor,
              title: specialistTitle,
              subtitle: specialistDescription,
              icon: "assets/icons/choose_profile/icon_specialist.png",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LFSMainScreen(startingIndex: 0,)),//will move to home screen
                );
              },
            ),
            ProfileContainer(
              color: navyColor,
              title: employTitle,
              subtitle: employDescription,
              icon: "assets/icons/choose_profile/icon_job.png",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LFJMainScreen(startingIndex: 0,)));
              },
            ),
            ProfileContainer(
              color: navyColor,
              title: customerBaseTitle,
              subtitle: customerBaseDescription,
              icon: "assets/icons/choose_profile/icon_clientele.png",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const IBMainScreen(startingIndex: 0,)));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String icon;
  final VoidCallback onPressed;

  const ProfileContainer({super.key,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size.height/4.5,
        width: size.width,
        decoration: BoxDecoration(
          border: Border.all(color: goldColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.oregano(
                textStyle: TextStyle(color: color, fontSize: 20),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.oregano(
                textStyle:
                TextStyle(color: color.withOpacity(0.7), fontSize: 15),
              ),
            ),
            const SizedBox(height: 10),
            Image(image: AssetImage(icon),height: (size.height < 601 || size.width < 305)? size.height/18 : size.height/15),
          ],
        ),
      ),
    );
  }
}