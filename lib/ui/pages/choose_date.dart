import 'package:flutix/model/cinema.dart';
import 'package:flutix/model/cinema_ticket.dart';
import 'package:flutix/model/cinema_time.dart';
import 'package:flutix/model/dates.dart';
import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/ui/widgets/cinema_tile.dart';
import 'package:flutix/ui/widgets/dates_tile.dart';
import 'package:flutix/ui/widgets/genre_tile.dart';
import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';

class ChooseDate extends StatefulWidget {
  final MoviePlaying? movie;
  const ChooseDate({Key? key, this.movie}) : super(key: key);

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
      CinemaTime(id: 1, cinemaName: "Paris Van Java", time: "12:20"),
      CinemaTime(id: 2, cinemaName: "Paris Van Java", time: "18:20"),
      CinemaTime(id: 3, cinemaName: "Paris Van Java", time: "15:40"),
      CinemaTime(id: 4, cinemaName: "Paris Van Java", time: "20:20"),
      CinemaTime(id: 5, cinemaName: "Paris Van Java", time: "23:20"),
    ]),
    Cinema(name: "Cihampelas Walk", times: [
      CinemaTime(id: 6, cinemaName: "Cihampelas Walk", time: "10:00")
    ]),
    Cinema(name: "Bandung Elektronik Center", times: [
      CinemaTime(id: 7, cinemaName: "Bandung Elektronik Center", time: "10:00")
    ]),
  ];

  List<String> selectedDate = <String>[];
  List<String> selectedTime = <String>[];
  Dates _selectedDate = Dates(date: "", day: "");
  // CinemaTime _cinemaTime = CinemaTime(id: 0, cinemaName: "", time: "")
  int timeId = 0;
  CinemaTime cinemaTimeSelected = CinemaTime(id: 0, cinemaName: "", time: "");
  CinemaTicket _cinemaTicket = CinemaTicket();

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;
    MoviePlaying? movie;
    if (arg is MoviePlaying) {
      movie = arg;
    }
    return (Scaffold(
      body: SafeArea(
        child: Container(
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
                                cinemaTime: cinemaTimeSelected,
                                onTap: (selectedCinemaTime) {
                                  _onSelectedTime(selectedCinemaTime);
                                },
                              )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonIcon(
                enabled: selectedDate.isNotEmpty && cinemaTimeSelected.id > 0
                    ? true
                    : false,
                onTap: () {
                  _cinemaTicket = CinemaTicket(
                      movie: movie,
                      date: "${_selectedDate.day} ${_selectedDate.date}",
                      time: cinemaTimeSelected.time,
                      cinema: cinemaTimeSelected.cinemaName);
                  Navigator.pushNamed(context, '/chooseRow',
                      arguments: _cinemaTicket);
                },
              )
            ],
          ),
        ),
      ),
    ));
  }

  void _onSelectedDate(int index) {
    setState(() {
      selectedDate = [];
      selectedDate.add(index.toString());
      _selectedDate = Dates(date: dates[index].date, day: dates[index].day);
    });
  }

  void _onSelectedTime(CinemaTime selectedCinemaTime) {
    setState(() {
      cinemaTimeSelected = selectedCinemaTime;
    });
  }
}
