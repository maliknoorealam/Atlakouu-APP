
import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/authentication/auth_button.dart';
import 'package:atalakou/widgets/common/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:atalakou/authentication/firebase_auth_service.dart';
import '../../widgets/common/notifs.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _termsAccepted = false;
  bool _isPasswordVisible = false; // Track password visibility
  bool _isConfirmPasswordVisible = false; // Track confirm password visibility

  bool isSigning = false;
  FirebaseAuthService authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'ATALAKOU',
          textAlign: TextAlign.right,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      border: Border.all(color: navyColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: BackArrow(iconColor: navyColor,iconSize: 18,)),
            ),
            const SizedBox(height: 20,),
            Text(
              signUpTitle,
              style: GoogleFonts.oregano(
                textStyle: TextStyle(color: goldColor, fontSize: 28),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            Text(
              email,
              style: GoogleFonts.oregano(
                textStyle: const TextStyle(color: navyColor, fontSize: 18),
              ),
              textAlign: TextAlign.left,
            ),
            _buildInputField('example@gmail.com', whiteColor,
                goldColor, _emailController),
            const SizedBox(height: 20),
            Text(
              createPassword,
              style: GoogleFonts.oregano(
                textStyle: const TextStyle(color: navyColor, fontSize: 18),
              ),
              textAlign: TextAlign.left,
            ),
            _buildInputField(createPasswordHintText,
                whiteColor, goldColor, _passwordController,
                isPassword: true),
            const SizedBox(height: 20),
            Text(
              confirmPassword,
              style: GoogleFonts.oregano(
                textStyle: const TextStyle(color: navyColor, fontSize: 18),
              ),
              textAlign: TextAlign.left,
            ),
            _buildInputField(confirmPasswordHintText, whiteColor,
                goldColor, _confirmPasswordController,
                isPassword: true, isConfirmPassword: true),
            const SizedBox(height: 50),
            Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: _termsAccepted,
                    onChanged: (bool value) {
                      setState(() {
                        _termsAccepted = value;
                      });
                    },
                    activeColor: whiteColor,
                    activeTrackColor: goldColor,
                    inactiveThumbColor: goldColor,
                    inactiveTrackColor: whiteColor,

                  ),
                ),
                Expanded(
                  child: Text(
                    acceptTerms,
                    style: TextStyle(color: navyColor, fontSize: (size.width > 395)? 16: 14)
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            AuthButton(
                text: submit, onPressed: _signUp, isSigning: isSigning),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  accountExists,
                  style: GoogleFonts.oregano(
                    textStyle: const TextStyle(color: navyColor, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle Login button press
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    logInTextButton,
                    style: GoogleFonts.oregano(
                      textStyle: TextStyle(
                          color: goldColor,
                          fontSize: 18), // Change color to gold
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, Color bgColor,
      Color textColor, TextEditingController controller,
      {bool isPassword = false, bool isConfirmPassword = false}) {
    bool isVisible =
        isConfirmPassword ? _isConfirmPasswordVisible : _isPasswordVisible;
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: goldColor), // Border color
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !isVisible,
        style: GoogleFonts.oregano(color: textColor),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: GoogleFonts.oregano(
              color: textColor
                  .withOpacity(0.7)), // Text inside container in Oregano
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: textColor,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isConfirmPassword) {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      } else {
                        _isPasswordVisible = !_isPasswordVisible;
                      }
                    });
                  },
                )
              : const SizedBox(), // Icon on the right
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigning = true;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (password != _confirmPasswordController.text) {
      showToast(passwordsDoNotMatch);
      setState(() {
        isSigning = false;
      });
    } else if (!_termsAccepted) {
      showToast(mustAcceptTerms);
      setState(() {
        isSigning = false;
      });
    } else {
      bool signed = await authService.signUpWithEmailAndPassword(email, password);
      if (signed) {
        // showToast(emailVerificationLinkSent);
        // isSigning = false;
        // int count = 0;
        // timer = Timer.periodic(const Duration(seconds: 5),
        //     (timer) async {
        //   print("Waiting for verification");
        //   count++;
        //       _auth.currentUser!.reload();
        //       if(_auth.currentUser!.emailVerified){
        //         showToast(signUpSuccess);
        //         timer.cancel();
        //         FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).set({
        //           'email': email,
        //           'creationTime': FieldValue.serverTimestamp(),
        //           'emailVerified': true,
        //         });
        //         _auth.signOut();
        //         Navigator.pop(context);
        //       }
        //       else if(count == 20){
        //         timer.cancel();
        //         showToast(emailLinkTimeOut);
        //         await authService.deleteUserAccount();
        //         Navigator.pop(context);
        //       }
        //     }
        // );

        showToast(signUpSuccess);
        Navigator.pop(context);
      }
      else{
        setState(() {
          isSigning = false;
        });
      }
    }
  }
}
