import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutix/model/cinema_ticket.dart';
import 'package:flutix/model/movie_model.dart';
import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/model/transaction.dart';
import 'package:flutix/model/user.dart';
import 'package:flutix/ui/pages/bloc/user_bloc.dart';
import 'package:flutix/ui/pages/change_profile.dart';
import 'package:flutix/ui/pages/checkout_movie.dart';
import 'package:flutix/ui/pages/checkout_success.dart';
import 'package:flutix/ui/pages/choose_date.dart';
import 'package:flutix/ui/pages/choose_row.dart';
import 'package:flutix/ui/pages/confirm_account.dart';
import 'package:flutix/ui/pages/error_page.dart';
import 'package:flutix/ui/pages/genre.dart';
import 'package:flutix/ui/pages/home.dart';
import 'package:flutix/ui/pages/init.dart';
import 'package:flutix/ui/pages/menu.dart';
import 'package:flutix/ui/pages/movie_detail.dart';
import 'package:flutix/ui/pages/my_wallet.dart';
import 'package:flutix/ui/pages/onboarding.dart';
import 'package:flutix/ui/pages/profile.dart';
import 'package:flutix/ui/pages/signin.dart' as SignInPage;
import 'package:flutix/ui/pages/signup.dart';
import 'package:flutix/ui/pages/ticket_detail.dart';
import 'package:flutix/ui/pages/topup.dart';
import 'package:flutix/ui/pages/topup_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      // GoRoute(
      //     path: '/init',
      //     name: 'init',
      //     builder: (context, state) {
      //       return const Init();
      //     }),
      GoRoute(
        path: '/topup_success',
        name: 'topup_success',
        builder: (context, state) {
          return const TopUpSuccess();
        },
      ),
      GoRoute(
        path: '/checkoutSuccess',
        name: 'checkoutSuccess',
        builder: (context, state) {
          return const CheckoutSuccess();
        },
      ),
      GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) {
            return const OnBoarding();
          },
          routes: [
            GoRoute(
              path: 'signin',
              name: 'signin',
              builder: (context, state) {
                return const SignInPage.SignIn();
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
                      routes: [
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
          ]),
      GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) {
            return Menu(
                selectedIndex:
                    int.parse(state.uri.queryParameters['index'] ?? '0'));
          },
          routes: [
            GoRoute(
                path: 'profile',
                name: 'profile',
                builder: (context, state) {
                  return const Profile();
                },
                routes: [
                  GoRoute(
                    path: 'change_profile',
                    name: 'change_profile',
                    builder: (context, state) {
                      return const ChangeProfile();
                    },
                  ),
                  GoRoute(
                      path: 'mywallet',
                      name: 'mywallet',
                      builder: (context, state) {
                        return const MyWallet();
                      },
                      routes: [
                        GoRoute(
                          path: 'ticketDetail',
                          name: 'ticketDetail',
                          builder: (context, state) {
                            Transactions trans = state.extra as Transactions;
                            return TicketDetail(transactions: trans);
                          },
                        )
                      ])
                ]),
            GoRoute(
                path: 'movieDetail',
                name: 'movieDetail',
                builder: (context, state) {
                  final extra = state.extra;
                  if (extra is MoviePlaying) {
                    return MovieDetail(movie: extra);
                  } else {
                    // Handle the case where state.extra is null or not of type MoviePlaying
                    // For example, show an error page or a placeholder
                    return const ErrorPage(
                        message: 'Invalid movie details provided');
                  }
                },
                routes: [
                  GoRoute(
                      path: 'chooseDate',
                      name: 'chooseDate',
                      builder: (context, state) {
                        // MoviePlaying movies = state.extra as MoviePlaying;
                        // return ChooseDate(movie: movies);
                        final movies = state.extra;
                        if (movies is MoviePlaying) {
                          return ChooseDate(movie: movies);
                        } else {
                          return const ErrorPage(
                              message: 'Invalid choose date provided');
                        }
                      },
                      routes: [
                        GoRoute(
                            path: 'chooseRow',
                            name: 'chooseRow',
                            builder: (context, state) {
                              final cinemaTicket = state.extra;
                              if (cinemaTicket is CinemaTicket) {
                                return ChooseRow(cinemaTicket: cinemaTicket);
                              } else {
                                return const ErrorPage(
                                    message: 'Invalid choose row provided');
                              }
                            },
                            routes: [
                              GoRoute(
                                  path: 'checkoutMovie',
                                  name: 'checkoutMovie',
                                  builder: (context, state) {
                                    final cinemaTicket =
                                        state.extra as CinemaTicket;
                                    return CheckoutMovie(
                                        cinemaTicket: cinemaTicket);
                                  })
                            ])
                      ])
                ]),
            GoRoute(
              path: 'topup',
              name: 'topup',
              builder: (context, state) {
                return const TopUp();
              },
            ),
            GoRoute(
              path: 'my_wallet_home',
              name: 'my_wallet_home',
              builder: (context, state) {
                return const MyWallet();
              },
            )
          ])
    ], initialLocation: '/onboarding', debugLogDiagnostics: true);
    return (BlocProvider(
      create: (context) => UserBloc()..add(CheckSignInStatus()),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is UserSignedIn) {
            router.goNamed('home');
          } else if (state is UserSignedOut) {
            log('onboarding test');
            router.goNamed('onboarding');
          }
        },
        child: MaterialApp.router(
          routeInformationProvider: router.routeInformationProvider,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          debugShowCheckedModeBanner: false,
        ),
      ),
    ));
  }
}
