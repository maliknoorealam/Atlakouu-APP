// ignore_for_file: library_private_types_in_public_api

import 'package:atalakou/authentication/firebase_auth_service.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common/bottom_sheet.dart';
import '../../widgets/lookingforjob/profilepage/profile_edit_tiles.dart';

class ServiceProfile extends StatefulWidget {
  const ServiceProfile({super.key});

  @override
  _ServiceProfileState createState() => _ServiceProfileState();
}

class _ServiceProfileState extends State<ServiceProfile> {
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          profile,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/vectors/common/icon_profile.svg",
              height: 75,
            ),
            const SizedBox(height: 10),
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: GoogleFonts.oregano(
                textStyle: const TextStyle(color: navyColor, fontSize: 24),
              ),
            ),
            const SizedBox(height: 50),
            ProfileEditTiles(
                onTap: () {
                  buildBottomSheet(context,
                      //passing the callback function
                      onTapFunction: () => firebaseAuthService.deleteUserAccount(),
                      sheetText: profileDeleteBottomScreenText);
                },
                leadingIcon: Icons.cancel,
                titleText: deleteAccount,
                isTrailingText: false),
            const SizedBox(height: 20),
            ProfileEditTiles(
                onTap: () {
                  buildBottomSheet(context,
                      onTapFunction: () => firebaseAuthService.signOut(),
                      sheetText: logoutConfirmation);
                },
                leadingIcon: Icons.logout_rounded,
                titleText: signOut,
                isTrailingText: false)
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onTap;

  // ignore: use_key_in_widget_constructors
  const ProfileOption({
    required this.text,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: navyColor, // Navy color
              ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.oregano(
                  textStyle: const TextStyle(color: navyColor, fontSize: 24),
                ), // Navy color
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: navyColor, // Navy color
            ),
          ],
        ),
      ),
    );
  }
}
