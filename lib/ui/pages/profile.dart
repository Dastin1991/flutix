import 'package:flutix/ui/widgets/header.dart';
import 'package:flutix/ui/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String fullname = "";
  String email = "";
  String profileUrl = "";
  String balance = "0";
  @override
  void initState() {
    super.initState();
    checkSharedPreferences();
  }

  Future<void> checkSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? _email = prefs.getString('email');
    String? _fullname = prefs.getString('fullname');
    String? _profileUrl = prefs.getString('profileUrl');

    setState(() {
      email = _email!;
      fullname = _fullname!;
      profileUrl = _profileUrl!;
    });
  }

  Future<void> logout(BuildContext context) async {
    // Get an instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Set isLogin to false
    await prefs.setBool('isLogin', false);
    await prefs.setString('email', "");

    // Navigate to the desired screen
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

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
                  child: profileUrl.isNotEmpty
                      ? Image(
                          image: NetworkImage(profileUrl),
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/user_pic.png')),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  fullname,
                  style: const TextStyle(fontFamily: 'Raleway', fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  email,
                  style: const TextStyle(
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
                      GestureDetector(
                        onTap: (() {
                          context.goNamed('change_profile');
                        }),
                        child: const Row(
                          children: [
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
                              style: TextStyle(
                                  fontFamily: 'Raleway', fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Separator(),
                      GestureDetector(
                        onTap: (() => context.goNamed('mywallet')),
                        child: const Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/ic_wallet.png'),
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "My Wallet",
                              style: TextStyle(
                                  fontFamily: 'Raleway', fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Separator(),
                      const Row(
                        children: [
                          Image(
                            image: AssetImage('assets/images/ic_language.png'),
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
                      const Row(
                        children: [
                          Image(
                            image: AssetImage('assets/images/ic_help.png'),
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
                      const Row(
                        children: [
                          Image(
                            image: AssetImage('assets/images/ic_rate.png'),
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
                      GestureDetector(
                        onTap: () async {
                          await logout(context);
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontFamily: 'Raleway'),
                        ),
                      )
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
