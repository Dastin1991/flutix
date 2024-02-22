import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutix/services/auth_services.dart';
import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthServices _auth = AuthServices();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conpasswordController = TextEditingController();

  bool _isButtonEnabled = false;

  // User _user;

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    _conpasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Add listeners to the text controllers
    _usernameController.addListener(_validateInputs);
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
    _conpasswordController.addListener(_validateInputs);
  }

  void _validateInputs() {
    // Update the state of the button based on the validation logic
    setState(() {
      _isButtonEnabled = _usernameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _conpasswordController.text.isNotEmpty &&
          _passwordController.text == _conpasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
        body: Container(
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
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    labelText: "Full Name", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: "Email Address", border: OutlineInputBorder()),
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
                height: 16,
              ),
              TextField(
                controller: _conpasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonIcon(
                enabled: _isButtonEnabled,
                onTap: () {
                  _signUp();
                },
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    print(email);
    print(username);

    // print('add users');
    try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        final firestore = FirebaseFirestore.instance;

        CollectionReference users = firestore.collection("users");
        users
            .add({
              'fullname': username, // John Doe
              'email': email, // John Doe
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        Navigator.pushNamed(context, '/genre');
      }
    } catch (e) {
      print("Some error occured");
      if (e is FirebaseAuthException) {
        showToastMessage(e.code);
      }
    }
  }

  void showToastMessage(String message) => Fluttertoast.showToast(msg: message);
}
