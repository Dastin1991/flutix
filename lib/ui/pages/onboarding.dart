import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Column(
                    children: const [
                      Image(image: AssetImage("assets/images/logo.png"))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  "New Experience",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: 200,
                  child: const Text(
                    "Watch a new movie much easier than any before",
                    style: TextStyle(
                      color: Color(0xffADADAD),
                      fontFamily: "Raleway",
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff503E9D),
                            foregroundColor: Colors.white),
                        onPressed: () {
                          debugPrint('go to signup');
                          context.goNamed('signup');
                        },
                        child: const Text("Get Started"))),
                const SizedBox(
                  height: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontFamily: "Raleway",
                          color: Color(0xffADADAD),
                          fontSize: 14),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      onTap: () => context.goNamed('signin'),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff503E9D)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
