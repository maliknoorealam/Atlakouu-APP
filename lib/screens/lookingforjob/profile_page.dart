import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/common/bottom_sheet.dart';
import 'package:atalakou/widgets/lookingforjob/profilepage/profile_edit_tiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../authentication/firebase_auth_service.dart';
import '../../widgets/common/back_arrow.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  String subscriptionDate = '';

  @override
  void initState() {
    getSubscriptionDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(profile),
        leading: BackArrow(),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: size.height / 3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/vectors/common/icon_profile.svg",
                      height: 75,
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.email!,
                      style: const TextStyle(
                          color: navyColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            ProfileEditTiles(
              onTap: () {},
              leadingIcon: Icons.abc,
              isSubscriptionIcon: true,
              titleText: subscriptionEnd,
              isTrailingText: true,
              trailingText: subscriptionDate,
            ),
            ProfileEditTiles(
                onTap: () {
                  buildBottomSheet(context,
                      onTapFunction: () => firebaseAuthService.deleteUserAccount(),
                      sheetText: profileDeleteBottomScreenText);
                },
                leadingIcon: Icons.cancel,
                titleText: deleteAccount,
                isTrailingText: false),
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

  getSubscriptionDate() async {
    DateTime? subsDate = await firebaseAuthService.getSubscriptionExpiryDate();
    setState(() {
      subscriptionDate = DateFormat('dd-MM-yy').format(subsDate!);
    });
  }
}
