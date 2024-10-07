// ignore_for_file: unused_label, camel_case_types


import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInOptions extends StatefulWidget {
  const SignInOptions({super.key});

  @override
  State<SignInOptions> createState() => _SignInOptionsState();
}

class _SignInOptionsState extends State<SignInOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ATALAKOU',
                style: GoogleFonts.oregano(
                  textStyle: const TextStyle(color: whiteColor, fontSize: 39),
                ),
              ),
              const SizedBox(height: 70),
              _buildOptionButton(signUp, goldColor, whiteColor, () {
                // Handle Sign In button press
                Navigator.pushNamed(context, '/SignIn');
              }),
              const SizedBox(height: 20),
              _buildOptionButton(logIn, goldColor, whiteColor, () {
                // Handle Login button press
                Navigator.pushNamed(context, '/login');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(
      String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, 65),
        backgroundColor: bgColor,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.oregano(
          textStyle: TextStyle(color: textColor, fontSize: 24),
        ),
      ),
    );
  }
}
