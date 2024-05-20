import 'package:flutter/material.dart';

class TimeTile extends StatelessWidget {
  final String time;
  final String? date;
  final Function onTap;
  final bool selected;

  TimeTile(
      {Key? key,
      this.date,
      required this.time,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentTime =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    debugPrint(currentTime);
    final isDisabled = _isTimeGreaterThanCurrent("${date!} $time", currentTime);

    return GestureDetector(
      onTap: () {
        !isDisabled ? null : onTap();
      },
      child: (Container(
        height: 50,
        width: 90,
        decoration: BoxDecoration(
            color: isDisabled
                ? selected
                    ? Colors.amber.shade300
                    : Colors.transparent
                : Color(0xFFDDDCDC),
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

  bool _isTimeGreaterThanCurrent(String time, String currentTime) {
    // Convert time strings to DateTime for comparison
    // debugPrint(currentTI)
    final timeDateTime = DateTime.parse("$time:00");
    // final currentDateTime = DateTime.parse("2024-05-20 0$currentTime:00");
    final currentDateTime = DateTime.parse(currentTime);

    // Compare the times
    return timeDateTime.isAfter(currentDateTime);
  }
}
