import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ProfileEditTiles extends StatelessWidget {
  ProfileEditTiles(
      {super.key,
      required this.onTap,
      required this.leadingIcon,
      required this.titleText,
      required this.isTrailingText,
      this.trailingText = "",
      this.isSubscriptionIcon = false});

  final VoidCallback onTap;
  final IconData leadingIcon;
  final String titleText;
  final bool isTrailingText;
  String? trailingText;
  bool isSubscriptionIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
          leading: isSubscriptionIcon
              ? const Image(
                  image: AssetImage(
                      "assets/icons/job_and_business/icon_end_subscription.png"),
                  height: 30,
                )
              : Icon(
                  leadingIcon,
                  size: 30,
                  color: navyColor,
                ),
          title: Text(
            titleText,
            style: const TextStyle(color: navyColor, fontSize: 24),
          ),
          trailing: isTrailingText
              ? Text(trailingText!,
                  style: const TextStyle(color: navyColor, fontSize: 22))
              : const Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                  color: navyColor,
                )),
    );
  }
}
