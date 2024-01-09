import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: 'Create New Account'),
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user_pic.png'),
                      radius: 60,
                      foregroundColor: Colors.black,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(top: 90),
                    child: IconButton(
                      splashRadius: 28,
                      onPressed: () {},
                      icon: Image.asset('assets/images/btn_add_photo.png'),
                      iconSize: 42,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const TextField(
                decoration: InputDecoration(
                    labelText: "Full Name", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 16,
              ),
              const TextField(
                decoration: InputDecoration(
                    labelText: "Email Address", border: OutlineInputBorder()),
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
                height: 16,
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonIcon(
                onTap: () {
                  Navigator.pushNamed(context, '/genre');
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
