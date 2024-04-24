import 'package:flutix/model/lucky_day.dart';
import 'package:flutter/material.dart';

class LuckyDayCard extends StatelessWidget {
  final LuckyDay luckyDay;
  const LuckyDayCard({Key? key, required this.luckyDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        SizedBox(
          width: double.infinity,
          height: 100,
          child: Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    luckyDay.title,
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  Text(
                    luckyDay.description,
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        color: Color(0xffA99BE3),
                        fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'OFF',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 18,
                      color: Color(0xFFFBD460),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    '${luckyDay.discount}%',
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        color: Color(0xFFFBD460)),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
