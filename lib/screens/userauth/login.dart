
import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/authentication/auth_button.dart';
import 'package:atalakou/widgets/common/back_arrow.dart';
import 'package:atalakou/widgets/common/notifs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../authentication/firebase_auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false; // Track password visibility

  FirebaseAuthService authService = FirebaseAuthService();
  bool isSigning = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          'ATALAKOU',
        ),
        leading: BackArrow(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height / 5),
            Text(
              logInGreetings,
              style: GoogleFonts.oregano(
                textStyle: TextStyle(color: goldColor, fontSize: 28),
              ),
              textAlign: TextAlign.left, // Align text to the left
            ),
            const SizedBox(height: 20),
            Text(
              email,
              style: GoogleFonts.oregano(
                textStyle: const TextStyle(color: navyColor, fontSize: 22),
              ),
              textAlign: TextAlign.left,
            ),
            _buildInputField('helloworld@gmail.com', whiteColor, goldColor,_emailController),
            const SizedBox(height: 20),
            Text(
              password,
              style: GoogleFonts.oregano(
                textStyle: const TextStyle(color: navyColor, fontSize: 22),
              ),
              textAlign: TextAlign.left,
            ),
            _buildInputField(password, whiteColor, goldColor,_passwordController,
                isPassword: true),
            const SizedBox(height: 20),
            // Align "Forget Password?" button to the right
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align to the right
              children: [
                TextButton(
                  onPressed: () {
                    // Handle Forget Password button press
                    Navigator.pushReplacementNamed(context, '/Forget_pass');
                  },
                  child: Text(
                    forgottenPassword,
                    style: GoogleFonts.oregano(
                      textStyle: const TextStyle(color: navyColor, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 65),
            AuthButton(text: logIn, onPressed: _signIn, isSigning: isSigning),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  noAccount,
                  style: GoogleFonts.oregano(
                    textStyle: const TextStyle(color: navyColor, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle Sign Up button press
                    Navigator.pushReplacementNamed(context, '/SignIn');
                  },
                  child: Text(
                    signUpTextButton,
                    style: GoogleFonts.oregano(
                      textStyle: TextStyle(
                          color: goldColor, fontSize: 18), // Change color to gold
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

  Widget _buildInputField(
      String label, Color bgColor, Color textColor,TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: goldColor), // Border color
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        style: GoogleFonts.oregano(color: navyColor),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: GoogleFonts.oregano(
              color: navyColor), // Text inside container in Oregano
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: textColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : Icon(Icons.check_circle,color: goldColor,), // Icon on the right
        ),
      ),
    );
  }


  void _signIn() async {
    setState(() {
      isSigning = true;
    });
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();


    bool logged = await authService.signInWithEmailAndPassword(
          email, password);
    if(logged){
      showToast(loginSuccess);
      Navigator.pop(context);
    }

    setState(() {
      isSigning = false;
    });
  }
}
