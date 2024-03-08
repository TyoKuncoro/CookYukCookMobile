import 'package:cook_yuk_cook/screens/login.dart';
import 'package:cook_yuk_cook/screens/loop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // user is logged in
        if (snapshot.hasData) {
          return const Loop();
        }
        // user is NOT logged in
        else {
          print(snapshot);
          return const Login();
        }
      },
    ));
  }
}
