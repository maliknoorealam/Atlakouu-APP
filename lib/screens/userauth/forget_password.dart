import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/authentication/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../authentication/firebase_auth_service.dart';
import '../../widgets/common/back_arrow.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isSigning = false;
  FirebaseAuthService authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ATALAKOU',
          textAlign: TextAlign.right,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40,),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      border: Border.all(color: navyColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: BackArrow(iconColor: navyColor,iconSize: 18,)),
            ),
            const SizedBox(height: 20),
            Text(
              resetPasswordTitle,
              style: GoogleFonts.oregano(
                textStyle: TextStyle(color: goldColor, fontSize: (size.width > 345)? 25: 20),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              resetPasswordGreetings,
              style: GoogleFonts.oregano(
                textStyle: const TextStyle(color: navyColor, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              email,
              style: GoogleFonts.oregano(
                textStyle: const TextStyle(color: navyColor, fontSize: 18),
              ),
              textAlign: TextAlign.left,
            ),
            _buildInputField(Icons.email, emailHintText, whiteColor, goldColor,_emailController),
            const SizedBox(height: 80),
            AuthButton(text: submit, onPressed: resetPass, isSigning: isSigning)
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      IconData icon, String label, Color bgColor, Color textColor, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: goldColor), // Border color
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: GoogleFonts.oregano(color: textColor),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: GoogleFonts.oregano(
              color: textColor
                  .withOpacity(0.7)), // Text inside container in Oregano
          suffixIcon: Icon(icon, color: textColor), // Icon on the right
        ),
      ),
    );
  }

  resetPass() async{
    setState(() {
      isSigning = true;
    });
    String email = _emailController.text;

    bool resetLink = await authService.resetPassword(email);

    if(resetLink){
      Navigator.pop(context);
    }
    else{
      setState(() {
        isSigning = false;
      });
    }
  }
}
