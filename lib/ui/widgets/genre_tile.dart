import 'package:flutter/material.dart';

class GenreTile extends StatelessWidget {
  final String title;
  final bool selected;

  VoidCallback onTap;

  GenreTile(
      {Key? key,
      required this.title,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: (Container(
        height: 60,
        width: (screenSize.width / 2) - 30,
        decoration: BoxDecoration(
            color: selected ? Colors.amber.shade300 : Colors.transparent,
            border: !selected ? Border.all(color: Color(0xffE4E4E4)) : null,
            borderRadius: BorderRadius.circular(6)),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(
              fontFamily: 'Raleway', fontSize: 16, fontWeight: FontWeight.w400),
        )),
      )),
    );
  }
}
