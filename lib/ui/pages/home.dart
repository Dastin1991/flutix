import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 134,
              decoration: const BoxDecoration(
                  color: Color(0xff2C1F63),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 64,
                        width: 64,
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/user_profile.jpeg'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Dadang Setiyawan",
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
