import 'package:flutix/model/chair.dart';
import 'package:flutix/ui/widgets/sheet_tile.dart';
import 'package:flutter/material.dart';

class ChairTile extends StatefulWidget {
  final Chair chair;
  final List<Sheet> seat;
  final Function onTap;
  const ChairTile(
      {super.key,
      required this.chair,
      required this.seat,
      required this.onTap});

  @override
  State<ChairTile> createState() => _ChairTileState();
}

class _ChairTileState extends State<ChairTile> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                  widget.chair.sheet.length,
                  (index) => SheetTile(
                      sheet: widget.chair.sheet[index].code,
                      selected: widget.seat.contains(widget.chair.sheet[index]),
                      onTap: () => _onSelectedSeat(widget.chair.sheet[index]))),
            ),
          )
        ],
      ),
    );
  }

  void _onSelectedSeat(Sheet seat) async {
    widget.onTap(seat);
  }
}
