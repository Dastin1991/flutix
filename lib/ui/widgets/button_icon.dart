import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  VoidCallback onTap;
  bool enabled;

  ButtonIcon({Key? key, required this.onTap, required this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Center(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: enabled ? Color(0xff503E9D) : Colors.grey),
        child: IconButton(
            onPressed: enabled ? onTap : null,
            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: Color(0xffffffff),
              size: 24,
            )),
      ),
    ));
  }
}
