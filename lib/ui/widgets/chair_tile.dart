import 'package:flutix/model/chair.dart';
import 'package:flutix/ui/widgets/sheet_tile.dart';
import 'package:flutter/material.dart';

class ChairTile extends StatelessWidget {
  final Chair chair;
  const ChairTile({super.key, required this.chair});
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
                  chair.sheet.length,
                  (index) => SheetTile(
                      sheet: chair.sheet[index].code,
                      selected: false,
                      onTap: () {})),
            ),
          )
        ],
      ),
    );
  }
}
