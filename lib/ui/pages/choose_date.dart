import 'package:flutix/model/cinema.dart';
import 'package:flutix/model/cinema_ticket.dart';
import 'package:flutix/model/cinema_time.dart';
import 'package:flutix/model/dates.dart';
import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutix/ui/widgets/cinema_tile.dart';
import 'package:flutix/ui/widgets/dates_tile.dart';
import 'package:flutix/ui/widgets/genre_tile.dart';
import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseDate extends StatefulWidget {
  final MoviePlaying? movie;
  const ChooseDate({Key? key, this.movie}) : super(key: key);

  @override
  State<ChooseDate> createState() => _ChooseDateState();
}

class _ChooseDateState extends State<ChooseDate> {
  List<Dates> dates = Utils.generateDatesForWeek(DateTime.now());

  List<Cinema> cinemas = [
    Cinema(name: "Paris Van Java", times: [
      CinemaTime(id: 1, cinemaName: "Paris Van Java", time: "12:20"),
      CinemaTime(id: 2, cinemaName: "Paris Van Java", time: "12:50"),
      CinemaTime(id: 3, cinemaName: "Paris Van Java", time: "14:25"),
      CinemaTime(id: 4, cinemaName: "Paris Van Java", time: "14:55"),
      CinemaTime(id: 5, cinemaName: "Paris Van Java", time: "16:30"),
      CinemaTime(id: 6, cinemaName: "Paris Van Java", time: "17:00"),
      CinemaTime(id: 7, cinemaName: "Paris Van Java", time: "18:35"),
      CinemaTime(id: 8, cinemaName: "Paris Van Java", time: "19:05"),
      CinemaTime(id: 9, cinemaName: "Paris Van Java", time: "20:40"),
      CinemaTime(id: 10, cinemaName: "Paris Van Java", time: "21:10"),
    ]),
    Cinema(name: "Cihampelas Walk", times: [
      CinemaTime(id: 11, cinemaName: "Cihampelas Walk", time: "12:20"),
      CinemaTime(id: 12, cinemaName: "Cihampelas Walk", time: "12:50"),
      CinemaTime(id: 13, cinemaName: "Cihampelas Walk", time: "14:25"),
      CinemaTime(id: 14, cinemaName: "Cihampelas Walk", time: "14:55"),
      CinemaTime(id: 15, cinemaName: "Cihampelas Walk", time: "16:30"),
      CinemaTime(id: 16, cinemaName: "Cihampelas Walk", time: "17:00"),
      CinemaTime(id: 17, cinemaName: "Cihampelas Walk", time: "18:35"),
      CinemaTime(id: 18, cinemaName: "Cihampelas Walk", time: "19:05"),
      CinemaTime(id: 19, cinemaName: "Cihampelas Walk", time: "20:40"),
      CinemaTime(id: 20, cinemaName: "Cihampelas Walk", time: "21:10"),
    ]),
    Cinema(name: "Bandung Elektronik Center", times: [
      CinemaTime(
          id: 21, cinemaName: "Bandung Elektronik Center", time: "12:20"),
      CinemaTime(
          id: 22, cinemaName: "Bandung Elektronik Center", time: "12:50"),
      CinemaTime(
          id: 23, cinemaName: "Bandung Elektronik Center", time: "14:25"),
      CinemaTime(
          id: 24, cinemaName: "Bandung Elektronik Center", time: "14:55"),
      CinemaTime(
          id: 25, cinemaName: "Bandung Elektronik Center", time: "16:30"),
      CinemaTime(
          id: 26, cinemaName: "Bandung Elektronik Center", time: "17:00"),
      CinemaTime(
          id: 27, cinemaName: "Bandung Elektronik Center", time: "18:35"),
      CinemaTime(
          id: 28, cinemaName: "Bandung Elektronik Center", time: "19:05"),
      CinemaTime(
          id: 29, cinemaName: "Bandung Elektronik Center", time: "20:40"),
      CinemaTime(
          id: 30, cinemaName: "Bandung Elektronik Center", time: "21:10"),
    ]),
  ];

  List<String> selectedDate = <String>[];
  List<String> selectedTime = <String>[];
  Dates _selectedDate = Dates(date: "", day: "", fulldate: "");
  int timeId = 0;
  CinemaTime cinemaTimeSelected = CinemaTime(id: 0, cinemaName: "", time: "");
  CinemaTicket _cinemaTicket = CinemaTicket();

  @override
  Widget build(BuildContext context) {
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
                    _selectedDate.date != ''
                        ? Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(
                                cinemas.length,
                                (index) => CinemaTile(
                                      cinemas: cinemas[index],
                                      cinemaTime: cinemaTimeSelected,
                                      selectedDate: _selectedDate.fulldate,
                                      onTap: (selectedCinemaTime) {
                                        _onSelectedTime(selectedCinemaTime);
                                      },
                                    )),
                          )
                        : Container()
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
                      movie: widget.movie,
                      date: "${_selectedDate.day} ${_selectedDate.date}",
                      time: cinemaTimeSelected.time,
                      cinema: cinemaTimeSelected.cinemaName);

                  context.goNamed('chooseRow', extra: _cinemaTicket);
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
      _selectedDate = Dates(
          date: dates[index].date,
          day: dates[index].day,
          fulldate: dates[index].fulldate);
    });
  }

  void _onSelectedTime(CinemaTime selectedCinemaTime) {
    setState(() {
      cinemaTimeSelected = selectedCinemaTime;
    });
  }
}
