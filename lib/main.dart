import 'package:flutix/ui/pages/confirm_account.dart';
import 'package:flutix/ui/pages/genre.dart';
import 'package:flutix/ui/pages/home.dart';
import 'package:flutix/ui/pages/onboarding.dart';
import 'package:flutix/ui/pages/signin.dart';
import 'package:flutix/ui/pages/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoarding(),
        '/signin': (context) => const SignIn(),
        '/signup': (context) => const SignUp(),
        '/genre': (context) => const Genre(),
        '/confirm': (context) => const ConfirmAccount(),
        '/home': (context) => const HomePage(),
      },
    ));
  }
}
