import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/api/services.dart';
import 'package:flutix/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserSignedOut()) {
    on<SignInBloc>((event, emit) async {
      if (state is UserSignedOut) {
        Services services = Services();

        String? token = await Services.getToken(
            email: event.email, password: event.password);

        if (token != null) {
          Future<UserProfile?> userFuture =
              services.getUser(email: event.email, token: token);

          UserProfile? user = await userFuture;

          if (user != null) {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString('email', event.email);
            pref.setString('fullname', user.fullname);
            pref.setString('token', token);

            emit(UserSignedIn(user));
          }
        }
      }
    });

    on<SignOut>((event, emit) async {
      if (state is UserSignedIn) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove('email');
        pref.remove('token');

        emit(UserSignedOut());
      }
    });

    on<CheckSignInStatus>((event, emit) async {
      Services services = Services();
      SharedPreferences pref = await SharedPreferences.getInstance();

      String? email = pref.getString('email');
      String? token = pref.getString('token');

      if (email != null && token != null) {
        bool tokenValid = Services.isTokenValid(token);

        if (tokenValid) {
          Future<UserProfile?> userFuture =
              services.getUser(email: email, token: token);

          UserProfile? user = await userFuture;

          if (user != null) {
            emit(UserSignedIn(user));
          }
        }
      }
    });
  }
}
