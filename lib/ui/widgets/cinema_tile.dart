import 'package:flutix/model/cinema.dart';
import 'package:flutix/model/dates.dart';
import 'package:flutix/ui/widgets/time_tile.dart';
import 'package:flutter/material.dart';

class CinemaTile extends StatefulWidget {
  final Cinema cinemas;

  CinemaTile({Key? key, required this.cinemas}) : super(key: key);

  @override
  State<CinemaTile> createState() => _CinemaTileState();
}

class _CinemaTileState extends State<CinemaTile> {
  List<String> selectedTime = <String>[];
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
                      selected: true,
                      onTap: () {})),
            ),
          )
        ],
      ),
    );
  }
}
