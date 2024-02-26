import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutix/services/auth_services.dart';
import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthServices _auth = AuthServices();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _image;
  final picker = ImagePicker();
  String _imageUrl = '';

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
                    child: _image == null
                        ? const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/user_pic.png'),
                            radius: 60,
                            foregroundColor: Colors.black,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(_image!),
                            radius: 60,
                            foregroundColor: Colors.black,
                          ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(top: 90),
                    child: IconButton(
                      splashRadius: 28,
                      onPressed: () {
                        showOptions();
                      },
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

  Future _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String userId = "";
    try {
      User? newUser = await _auth.signUpWithEmailAndPassword(email, password);
      if (newUser != null) {
        final userId = newUser.uid;
        final firestore = FirebaseFirestore.instance;

        CollectionReference users = firestore.collection("users");
        users
            .doc(userId)
            .set({
              'fullname': username, // John Doe
              'email': email, // John Doe
            })
            .then((value) => {
                  users.doc(userId).collection('ewallet').add({
                    'balance': 0,
                  }).then((_) {
                    print("User and wallet added successfully");
                  }).catchError((error) {
                    print("Failed to add wallet: $error");
                  })
                })
            .catchError((error) => print("Failed to add user: $error"));

        if (_image != null) {
          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('user_profile_images')
              .child('${DateTime.now()}.jpg');

          firebase_storage.UploadTask uploadTask = ref.putFile(_image!);
          await uploadTask.whenComplete(() async {
            _imageUrl = await ref.getDownloadURL();
            print('Image uploaded to Firebase Storage: $_imageUrl');

            // Save image URL to Firestore
            await _firestore.collection('users').doc(userId).update({
              'profileImageUrl': _imageUrl,
            });
          });
        }

        User? user = await _auth.signInWithEmailAndPassword(email, password);
        if (user != null) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("email", user.email.toString());

          pref.setBool("isLogin", true);

          DocumentSnapshot userSnapshot = await getUserByEmail(email);

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
          Navigator.pushNamed(context, '/genre');
        }
      }
    } catch (e) {
      print("Some error occured");
      if (e is FirebaseAuthException) {
        showToastMessage(e.code);
      }
    }
  }

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  void showToastMessage(String message) => Fluttertoast.showToast(msg: message);
}
