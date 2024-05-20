import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutix/model/user.dart';
import 'package:flutix/ui/pages/change_profile.dart';
import 'package:flutix/ui/pages/checkout_movie.dart';
import 'package:flutix/ui/pages/checkout_success.dart';
import 'package:flutix/ui/pages/choose_date.dart';
import 'package:flutix/ui/pages/choose_row.dart';
import 'package:flutix/ui/pages/confirm_account.dart';
import 'package:flutix/ui/pages/genre.dart';
import 'package:flutix/ui/pages/home.dart';
import 'package:flutix/ui/pages/init.dart';
import 'package:flutix/ui/pages/menu.dart';
import 'package:flutix/ui/pages/movie_detail.dart';
import 'package:flutix/ui/pages/my_wallet.dart';
import 'package:flutix/ui/pages/onboarding.dart';
import 'package:flutix/ui/pages/profile.dart';
import 'package:flutix/ui/pages/signin.dart';
import 'package:flutix/ui/pages/signup.dart';
import 'package:flutix/ui/pages/ticket_detail.dart';
import 'package:flutix/ui/pages/topup.dart';
import 'package:flutix/ui/pages/topup_success.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(routes: [
      GoRoute(
          path: '/init',
          name: 'init',
          builder: (context, state) {
            return const Init();
          }),
      GoRoute(
          path: '/',
          name: 'onboarding',
          builder: (context, state) {
            return const OnBoarding();
          },
          routes: [
            GoRoute(
              path: 'signin',
              name: 'signin',
              builder: (context, state) {
                return const SignIn();
              },
            ),
            GoRoute(
                path: 'signup',
                name: 'signup',
                builder: (context, state) {
                  return const SignUp();
                },
                routes: [
                  GoRoute(
                    path: 'genre',
                    name: 'genre',
                    builder: (context, state) {
                      UserProfile users = state.extra as UserProfile;
                      return Genre(users: users);
                    },
                  ),
                  GoRoute(
                    path: 'confirm',
                    name: 'confirm',
                    builder: (context, state) {
                      UserProfile users = state.extra as UserProfile;
                      return ConfirmAccount(users: users);
                    },
                  ),
                ]),
          ]),
      GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) {
            return Menu(selectedIndex: 0);
          })
    ], initialLocation: '/init', debugLogDiagnostics: true);
    return (MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      // routes: {
      //   '/': (_) => const Init(),
      //   '/onBoarding': (_) => const OnBoarding(),
      //   '/signin': (_) => const SignIn(),
      //   '/signup': (_) => const SignUp(),
      //   '/genre': (_) => Genre(),
      //   '/confirm': (_) => ConfirmAccount(),
      //   '/home': (_) => Menu(selectedIndex: 0),
      //   '/movieDetail': (_) => const MovieDetail(),
      //   '/chooseDate': (_) => const ChooseDate(),
      //   '/chooseRow': (_) => const ChooseRow(),
      //   '/checkoutMovie': (_) => const CheckoutMovie(),
      //   '/checkoutSuccess': (_) => const CheckoutSuccess(),
      //   '/profile': (_) => const Profile(),
      //   '/changeProfile': (_) => const ChangeProfile(),
      //   '/myWallet': (_) => const MyWallet(),
      //   '/topup': (_) => const TopUp(),
      //   '/topupSuccess': (_) => const TopUpSuccess(),
      //   '/ticketDetail': (_) => const TicketDetail(),
      // },
    ));
  }
}
