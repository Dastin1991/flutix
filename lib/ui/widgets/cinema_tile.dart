import 'package:flutix/model/cinema.dart';
import 'package:flutix/model/cinema_time.dart';
import 'package:flutix/model/dates.dart';
import 'package:flutix/ui/widgets/time_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CinemaTile extends StatefulWidget {
  final Cinema cinemas;
  final CinemaTime cinemaTime;
  final Function onTap;

  CinemaTile(
      {Key? key,
      required this.cinemas,
      required this.onTap,
      required this.cinemaTime})
      : super(key: key);

  @override
  State<CinemaTile> createState() => _CinemaTileState();
}

class _CinemaTileState extends State<CinemaTile> {
  List<String> selectedTime = <String>[];
  // late int _receivedParam;
  // late int selectedTimeId; // Track the selected time ID

  @override
  void initState() {
    super.initState();
    // selectedTimeId = widget.timeId; // Initialize selected time ID
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.cinemas.name,
            style: const TextStyle(fontFamily: 'Raleway', fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                  widget.cinemas.times.length,
                  (index) => TimeTile(
                      time: widget.cinemas.times[index].time,
                      selected: widget.cinemaTime == widget.cinemas.times[index]
                          ? true
                          : false,
                      onTap: () =>
                          _onSelectedTime(widget.cinemas.times[index]))),
            ),
          )
        ],
      ),
    );
  }

  void _onSelectedTime(CinemaTime cinemaTime) async {
    widget.onTap(cinemaTime);
  }
}
