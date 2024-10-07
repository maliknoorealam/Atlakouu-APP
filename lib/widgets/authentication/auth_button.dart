import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
        required this.text,
        required this.onPressed,
        required this.isSigning});
  final bool isSigning;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onPressed,
        child: isSigning
            ? const CircularProgressIndicator(color: navyColor,)
            : Text(
          text,
          style: const TextStyle(fontSize: 20,color: whiteColor),
        ));
  }
}
