import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutix/model/user.dart';
import 'package:flutix/services/auth_services.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ConfirmAccount extends StatefulWidget {
  UserProfile? users;
  ConfirmAccount({super.key, this.users});

  @override
  State<ConfirmAccount> createState() => _ConfirmAccountState();
}

class _ConfirmAccountState extends State<ConfirmAccount> {
  final AuthServices _auth = AuthServices();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    // checkSharedPreferences();
    super.initState();
  }

  // Future<void> checkSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String? fullname = prefs.getString('fullname');
  //   print(fullname);
  //   setState(() {
  //     fullname = fullname!;
  //   });
  // }

  Future<void> createAccount(UserProfile userProfile) async {
    String username = userProfile!.fullname;
    String email = userProfile!.email;
    String password = userProfile!.password!;
    File? _image = userProfile!.pathImage ?? userProfile!.pathImage;
    String? _imageUrl = "";
    String userId = "";
    try {
      User? newUser = await _auth.signUpWithEmailAndPassword(email, password);
      if (newUser != null) {
        final userId = newUser.uid;
        final firestore = FirebaseFirestore.instance;

        int randomNumber = Utils.generateCodeNumber();
        CollectionReference users = firestore.collection("users");
        users
            .doc(userId)
            .set({
              'fullname': username,
              'email': email,
              'genre': userProfile.genre,
              'language': userProfile.language,
            })
            .then((value) => {
                  users.doc(userId).collection('ewallet').add(
                      {'balance': 0, 'cardId': 'BWA$randomNumber'}).then((_) {
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
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false,
              arguments: {'selectedIndex': 0});
        }
      }
    } catch (e) {
      print("Some error occured");
      if (e is FirebaseAuthException) {
        showToastMessage(e.code);
      }
    }
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

  void showToastMessage(String message) => Fluttertoast.showToast(msg: message);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;
    UserProfile? userProfile;
    if (arg is UserProfile) {
      userProfile = arg;
    }
    return SafeArea(
      child: (Scaffold(
        body: Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: 'Confirm New Account'),
              Flexible(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: userProfile?.pathImage != null
                            ? CircleAvatar(
                                backgroundImage:
                                    FileImage(userProfile!.pathImage!),
                              )
                            : const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/user_pic.png'),
                                radius: 60,
                                foregroundColor: Colors.black,
                              ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Welcome",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        userProfile!.fullname,
                        style: const TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff3E9D9D),
                            foregroundColor: Colors.white),
                        onPressed: () {
                          createAccount(userProfile!);
                        },
                        child: const Text(
                          "Create My Account",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ))),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
