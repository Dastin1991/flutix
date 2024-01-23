import 'package:flutter/material.dart';

class TimeTile extends StatelessWidget {
  final String time;
  final bool selected;

  VoidCallback onTap;

  TimeTile(
      {Key? key,
      required this.time,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: (Container(
        height: 50,
        width: 90,
        decoration: BoxDecoration(
            color: selected ? Colors.amber.shade300 : Colors.transparent,
            border: !selected ? Border.all(color: Color(0xffE4E4E4)) : null,
            borderRadius: BorderRadius.circular(6)),
        child: Center(
            child: Text(
          time,
          style: const TextStyle(
              fontFamily: 'Raleway', fontSize: 16, fontWeight: FontWeight.w400),
        )),
      )),
    );
  }
}
