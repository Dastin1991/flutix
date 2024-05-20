import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Init extends StatefulWidget {
  const Init({super.key});

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  bool isLogin = false;
  bool isStarted = false;
  String cek = "";
  @override
  void initState() {
    checkSharedPreferences();
    super.initState();
  }

  Future<void> checkSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isLogin = prefs.getBool('isLogin');
    if (isLogin != null && isLogin) {
      context.goNamed('home');
    } else {
      context.goNamed('onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
