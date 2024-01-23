import 'package:flutix/model/cinema.dart';
import 'package:flutix/model/cinema_time.dart';
import 'package:flutix/model/dates.dart';
import 'package:flutix/ui/widgets/cinema_tile.dart';
import 'package:flutix/ui/widgets/dates_tile.dart';
import 'package:flutix/ui/widgets/genre_tile.dart';
import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';

class ChooseDate extends StatefulWidget {
  const ChooseDate({Key? key}) : super(key: key);

  @override
  State<ChooseDate> createState() => _ChooseDateState();
}

class _ChooseDateState extends State<ChooseDate> {
  List<Dates> dates = [
    Dates(date: '21', day: 'SAT'),
    Dates(date: '22', day: 'SUN'),
    Dates(date: '23', day: 'MON'),
    Dates(date: '24', day: 'TUE'),
    Dates(date: '25', day: 'WED'),
  ];

  List<Cinema> cinemas = [
    Cinema(name: "Paris Van Java", times: [
      CinemaTime(time: "12:20"),
      CinemaTime(time: "15:40"),
      CinemaTime(time: "18:20"),
      CinemaTime(time: "20:20"),
      CinemaTime(time: "23:20"),
    ]),
    Cinema(name: "Cihampelas Walk", times: [CinemaTime(time: "10:00")]),
    Cinema(
        name: "Bandung Elektronik Center", times: [CinemaTime(time: "10:00")]),
  ];

  List<String> selectedDate = <String>[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: ''),
              Container(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose Date',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                            dates.length,
                            (index) => DatesTile(
                                dates: dates[index],
                                selected:
                                    selectedDate.contains(index.toString())
                                        ? true
                                        : false,
                                onTap: () {
                                  _onSelectedDate(index);
                                })),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                          cinemas.length,
                          (index) => CinemaTile(
                                cinemas: cinemas[index],
                              )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonIcon(
                onTap: () {
                  Navigator.pushNamed(context, '/chooseRow');
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  void _onSelectedDate(int index) {
    setState(() {
      selectedDate = [];
      selectedDate.add(index.toString());
    });
  }
}
