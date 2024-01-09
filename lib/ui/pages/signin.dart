import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Image(
                        image: AssetImage("assets/images/logo.png"),
                        width: 70,
                        height: 70,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const Text("Explorer",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 50,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          labelText: "Email Address",
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password", border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonIcon(
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Start fresh now?",
                          style: TextStyle(
                              fontFamily: "Raleway",
                              color: Color(0xffADADAD),
                              fontSize: 14),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, '/signup'),
                          child: const Text(
                            "Sign Up",
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
            ],
          ),
        ),
      ),
    ));
  }
}
