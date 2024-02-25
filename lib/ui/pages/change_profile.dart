import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({Key? key}) : super(key: key);

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late File _image;
  final picker = ImagePicker();
  String _imageUrl = '';

  String? fullname = "";
  String? email = "";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _fullnameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkSharedPreferences();
  }

  // Function to update Firestore with user's new full name
  Future<void> updateFullName(String newFullName) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get the user's unique ID (UID)
        String userId = user.uid;

        // Reference to the Firestore collection 'users'
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        // Update the document in the 'users' collection with the given userId
        await users.doc(userId).update({'fullname': newFullName});

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('fullname', newFullName);

        print('Full name updated successfully');

        if (_image != null) {
          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('user_profile_images')
              .child('${DateTime.now()}.jpg');

          firebase_storage.UploadTask uploadTask = ref.putFile(_image);
          await uploadTask.whenComplete(() async {
            _imageUrl = await ref.getDownloadURL();
            print('Image uploaded to Firebase Storage: $_imageUrl');

            // Save image URL to Firestore
            await _firestore.collection('users').doc(userId).update({
              'profileImageUrl': _imageUrl,
            });
          });
        }
      } else {
        print('No user signed in');
      }
    } catch (e) {
      print('Error updating full name: $e');
    }
  }

  //get shared pref
  Future<void> checkSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    fullname = await prefs.getString('fullname');
    email = await prefs.getString('email');

    _fullnameController.text = fullname!;
    _emailController.text = email!;

    print("$fullname - $email");
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
              // Center(
              //   child: _image == null
              //       ? Text('No Image selected')
              //       : Image.file(_image!),
              // ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: _fullnameController,
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
                        onPressed: () {
                          updateFullName(_fullnameController.text);
                        },
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
