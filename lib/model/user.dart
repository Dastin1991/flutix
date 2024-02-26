import 'dart:io';

class UserProfile {
  String fullname;
  String email;
  String? password;
  String? photo;
  String? genre;
  String? language;
  File? pathImage;

  UserProfile(
      {required this.fullname,
      required this.email,
      this.password,
      this.photo,
      this.genre,
      this.language,
      this.pathImage});
}
