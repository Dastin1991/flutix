import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutix/services/auth_services.dart';
import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _authServices = AuthServices();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Add listeners to the text controllers
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
  }

  void _validateInputs() {
    // Update the state of the button based on the validation logic
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
        body: Container(
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
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          labelText: "Email Address",
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: "Password", border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonIcon(
                      enabled: _isButtonEnabled,
                      onTap: () {
                        _signIn();
                      },
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
      )),
    );
  }

  Future<DocumentSnapshot> getUserByEmail(String email) async {
    // Reference to the "users" collection in Firestore
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Query for the user document with the provided email
    QuerySnapshot querySnapshot =
        await usersCollection.where('email', isEqualTo: email).get();

    // Check if the query returned any documents
    if (querySnapshot.docs.isNotEmpty) {
      // Return the first document found (assuming email is unique)
      return querySnapshot.docs.first;
    } else {
      // Handle the case where no user with the provided email was found
      throw Exception('User not found for email: $email');
    }
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      User? user =
          await _authServices.signInWithEmailAndPassword(email, password);
      if (user != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("email", user.email.toString());

        pref.setBool("isLogin", true);

        DocumentSnapshot userSnapshot = await getUserByEmail(email!);

        if (userSnapshot.exists) {
          // User data found, you can access it using userSnapshot.data()
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          String userFullname = userData['fullname'];
          pref.setString("fullname", userFullname);
        } else {
          print('User not found for email: $email');
        }
        // print("Login successfully");
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (e) {
      print("Some error occured" + e.toString());
      if (e is FirebaseAuthException) {
        showToastMessage(e.code);
      }
    }
  }

  void showToastMessage(String message) => Fluttertoast.showToast(msg: message);
}
