import 'package:flutix/ui/pages/checkout_movie.dart';
import 'package:flutix/ui/pages/checkout_success.dart';
import 'package:flutix/ui/pages/choose_date.dart';
import 'package:flutix/ui/pages/choose_row.dart';
import 'package:flutix/ui/pages/confirm_account.dart';
import 'package:flutix/ui/pages/genre.dart';
import 'package:flutix/ui/pages/home.dart';
import 'package:flutix/ui/pages/menu.dart';
import 'package:flutix/ui/pages/movie_detail.dart';
import 'package:flutix/ui/pages/onboarding.dart';
import 'package:flutix/ui/pages/profile.dart';
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
        '/': (_) => const OnBoarding(),
        '/signin': (_) => const SignIn(),
        '/signup': (_) => const SignUp(),
        '/genre': (_) => const Genre(),
        '/confirm': (_) => const ConfirmAccount(),
        '/home': (_) => const Menu(),
        '/movieDetail': (_) => const MovieDetail(),
        '/chooseDate': (_) => const ChooseDate(),
        '/chooseRow': (_) => const ChooseRow(),
        '/checkoutMovie': (_) => const CheckoutMovie(),
        '/checkoutSuccess': (_) => const CheckoutSuccess(),
        '/profile': (_) => const Profile(),
      },
    ));
  }
}
