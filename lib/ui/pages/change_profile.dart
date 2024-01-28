import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';

class ChangeProfile extends StatelessWidget {
  const ChangeProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: 'Edit Your Profile'),
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
              Center(
                child: SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff3E9D9D),
                            foregroundColor: Colors.white),
                        onPressed: () {},
                        child: const Text(
                          "Update My Profile",
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
