import 'dart:ffi';

import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';

class ConfirmAccount extends StatelessWidget {
  const ConfirmAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: 'Confirm New Account'),
              Flexible(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/user_profile.jpeg'),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Welcome",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        "Dadang Setiyawan",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff3E9D9D)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: const Text(
                          "Create My Account",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ))),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
