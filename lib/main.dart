import 'package:cook_yuk_cook/firebase_options.dart';
import 'package:cook_yuk_cook/screens/authPage.dart';
import 'package:cook_yuk_cook/screens/login.dart';
import 'package:cook_yuk_cook/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthPage()));
    });
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/cyc.png"),
      ),
    );
  }
}
