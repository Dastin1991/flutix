import 'package:flutter/material.dart';
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
    String? email = prefs.getString('email');
    String? fullname = prefs.getString('fullname');
    print(fullname);
    if (isLogin != null && isLogin) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false,
          arguments: {'selectedIndex': 0});
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/onBoarding', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
