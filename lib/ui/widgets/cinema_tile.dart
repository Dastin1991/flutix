import 'package:flutix/model/cinema.dart';
import 'package:flutix/model/dates.dart';
import 'package:flutix/ui/widgets/time_tile.dart';
import 'package:flutter/material.dart';

class CinemaTile extends StatelessWidget {
  final Cinema cinemas;

  CinemaTile({Key? key, required this.cinemas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cinemas.name,
            style: const TextStyle(fontFamily: 'Raleway', fontSize: 20),
          ),
          SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                  cinemas.times.length,
                  (index) => TimeTile(
                      time: cinemas.times[index].time,
                      selected: false,
                      onTap: () {})),
            ),
          )
        ],
      ),
    );
  }
}
