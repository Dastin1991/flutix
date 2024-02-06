import 'package:flutter/material.dart';

class TopUpTile extends StatelessWidget {
  final int title;
  final bool selected;

  VoidCallback onTap;

  TopUpTile(
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
        width: (screenSize.width / 3) - 30,
        decoration: BoxDecoration(
            color: selected ? Colors.amber.shade300 : Colors.transparent,
            border: !selected ? Border.all(color: Color(0xffE4E4E4)) : null,
            borderRadius: BorderRadius.circular(6)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "IDR",
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              title.toString(),
              style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ],
        )),
      )),
    );
  }
}
