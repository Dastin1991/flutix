import 'package:flutix/model/dates.dart';
import 'package:flutter/material.dart';

class DatesTile extends StatelessWidget {
  final Dates dates;
  final Function onTap;
  final bool selected;

  DatesTile(
      {Key? key,
      required this.dates,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onTap(),
      child: (Container(
        width: 70,
        height: 90,
        decoration: BoxDecoration(
            color: selected ? Colors.amber.shade300 : Colors.transparent,
            border: !selected ? Border.all(color: Color(0xffE4E4E4)) : null,
            borderRadius: BorderRadius.circular(6)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              dates.day,
              style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              dates.date,
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
