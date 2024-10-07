import 'package:atalakou/screens/userauth/login_main_screen.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key, required this.screen});
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
              return screen;
            // if(snapshot.data!.emailVerified)
            // {
            //   return screen;
            // }
            // else{
            //   return const SignIn_options();
            // }
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return const PlaceHolderScreen();
          }
          else{
            return const SignInOptions();
          }
        },
      ),
    );
  }
}

class PlaceHolderScreen extends StatelessWidget {
  const PlaceHolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: goldColor,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
