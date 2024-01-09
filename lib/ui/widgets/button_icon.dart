import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  VoidCallback onTap;

  ButtonIcon({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Center(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xff503E9D)),
        child: IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: Color(0xffffffff),
              size: 24,
            )),
      ),
    ));
  }
}
