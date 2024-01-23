import 'package:flutix/ui/widgets/header.dart';
import 'package:flutix/ui/widgets/separator.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(title: ''),
            const SizedBox(
              height: 24,
            ),
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                    image: AssetImage('assets/images/user_profile.jpeg'),
                    height: 120,
                    width: 120,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Dadang Setiyawan",
                  style: TextStyle(fontFamily: 'Raleway', fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "dadangsetiyawan20@gmail.com",
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 16,
                      color: Color(0xFFADADAD)),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Image(
                            image: AssetImage('assets/images/ic_account.png'),
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Edit Profile",
                            style:
                                TextStyle(fontFamily: 'Raleway', fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Separator(),
                      Row(
                        children: const [
                          Image(
                            image: AssetImage('assets/images/ic_account.png'),
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "My Wallet",
                            style:
                                TextStyle(fontFamily: 'Raleway', fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Separator(),
                      Row(
                        children: const [
                          Image(
                            image: AssetImage('assets/images/ic_account.png'),
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Change Language",
                            style:
                                TextStyle(fontFamily: 'Raleway', fontSize: 16),
                          ),
                        ],
                      ),
                      const Separator(),
                      Row(
                        children: const [
                          Image(
                            image: AssetImage('assets/images/ic_account.png'),
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Help Centre",
                            style:
                                TextStyle(fontFamily: 'Raleway', fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Separator(),
                      Row(
                        children: const [
                          Image(
                            image: AssetImage('assets/images/ic_account.png'),
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Rate Flutix App",
                            style:
                                TextStyle(fontFamily: 'Raleway', fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Separator(),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
