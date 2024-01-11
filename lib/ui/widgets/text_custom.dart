import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String title;
  const TextCustom({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Text(
      title,
      style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
    ));
  }
}
