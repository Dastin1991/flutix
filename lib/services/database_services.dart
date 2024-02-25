import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseServices {
  static Future<String> uploadImage(File imageFile) async {
    String filename = basename(imageFile.path);

    return filename;
  }
}
