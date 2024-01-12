import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
                Container(
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      Image(image: AssetImage("assets/images/logo.png"))
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Text(
                  "New Experience",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: 200,
                  child: Text(
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
                SizedBox(
                  height: 70,
                ),
                Container(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff503E9D)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text("Get Started"))),
                SizedBox(
                  height: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontFamily: "Raleway",
                          color: Color(0xffADADAD),
                          fontSize: 14),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/signin'),
                      child: Text(
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
