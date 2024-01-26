import 'package:flutix/model/chair.dart';
import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutix/ui/widgets/chair_tile.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutix/ui/widgets/header_content.dart';
import 'package:flutter/material.dart';

class ChooseRow extends StatefulWidget {
  const ChooseRow({super.key});

  @override
  State<ChooseRow> createState() => _ChooseRowState();
}

class _ChooseRowState extends State<ChooseRow> {
  List<Chair> chair = [
    Chair(id: 1, sheet: [
      Sheet(code: "A1"),
      Sheet(code: "A2"),
      Sheet(code: "A3"),
    ]),
    Chair(id: 2, sheet: [
      Sheet(code: "B1"),
      Sheet(code: "B2"),
      Sheet(code: "B3"),
      Sheet(code: "B4"),
      Sheet(code: "B5"),
    ]),
    Chair(id: 3, sheet: [
      Sheet(code: "C1"),
      Sheet(code: "C2"),
      Sheet(code: "C3"),
      Sheet(code: "C4"),
      Sheet(code: "C5"),
    ]),
    Chair(id: 4, sheet: [
      Sheet(code: "D1"),
      Sheet(code: "D2"),
      Sheet(code: "D3"),
      Sheet(code: "D4"),
      Sheet(code: "D5"),
    ]),
    Chair(id: 5, sheet: [
      Sheet(code: "E1"),
      Sheet(code: "E2"),
      Sheet(code: "E3"),
      Sheet(code: "E4"),
      Sheet(code: "E5"),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderContent(title: ''),
            Wrap(
              runSpacing: 15,
              spacing: 10,
              children: List.generate(
                  chair.length, (index) => ChairTile(chair: chair[index])),
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonIcon(
              onTap: () {
                Navigator.pushNamed(context, '/checkoutMovie');
              },
            )
          ],
        ),
      ),
    );
  }
}
