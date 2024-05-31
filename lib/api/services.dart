import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutix/model/user.dart';

class Services {
  Future<UserProfile?> getUser(
      {required String email, required String token}) async {
    DocumentSnapshot userSnapshot = await getUserByEmail(email);

    if (userSnapshot.exists) {
      // User data found, you can access it using userSnapshot.data()
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      String userFullname = userData['fullname'];
      String userProfile = userData.containsKey('profileImageUrl')
          ? userData['profileImageUrl']
          : '';
      return UserProfile(fullname: userFullname, email: email, token: token);
    } else {
      // Handle the case where user does not exist
      return null;
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

  static Future<String?> getToken(
      {required String email, required String password}) async {
    //login firebase disini
    log("login disini");
    final FirebaseAuth _auth = FirebaseAuth.instance;
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;
    if (user != null) {
      return 'ABADSAFDSFADSFASDFA';
      // SharedPreferences pref = await SharedPreferences.getInstance();
      // pref.setString("email", user.email.toString());

      // pref.setBool("isLogin", true);

      // DocumentSnapshot userSnapshot = await getUserByEmail(email!);

      // if (userSnapshot.exists) {
      //   // User data found, you can access it using userSnapshot.data()
      //   Map<String, dynamic> userData =
      //       userSnapshot.data() as Map<String, dynamic>;
      //   String userFullname = userData['fullname'];
      //   pref.setString("fullname", userFullname);
      // } else {
      //   print('User not found for email: $email');
      // }
      // // print("Login successfully");
      // Navigator.of(context).pop();
      // context.goNamed('home', queryParameters: {'index': '0'});
    }
    // if (email == 'dadangsetiyawan20@gmail.com' && password == '123456') {
    //   return 'ABADSAFDSFADSFASDFA';
    // }
    return null;
  }

  static bool isTokenValid(String token) {
    return true;
  }
}
