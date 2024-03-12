import 'package:flutix/model/chair.dart';
import 'package:flutix/model/cinema_ticket.dart';
import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutix/ui/widgets/chair_tile.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutix/ui/widgets/header_content.dart';
import 'package:flutter/material.dart';

class ChooseRow extends StatefulWidget {
  final CinemaTicket? cinemaTicket;
  const ChooseRow({super.key, this.cinemaTicket});

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

  List<String> selectedSeat = <String>[];
  List<String> _selectedSeat = <String>[];
  List<Sheet> seatSelected = [];

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;
    CinemaTicket? cinemaTicket;
    if (arg is CinemaTicket) {
      cinemaTicket = arg;
    }
    return Scaffold(
      body: cinemaTicket != null
          ? SafeArea(
              child: Column(
                children: [
                  HeaderContent(
                      title: cinemaTicket.movie!.title,
                      link: cinemaTicket.movie!.link),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 8.0),
                    child: Image(
                        image:
                            AssetImage('assets/images/ic_cinema_screen.png')),
                  ),
                  Wrap(
                    runSpacing: 15,
                    spacing: 10,
                    children: List.generate(
                        chair.length,
                        (index) => ChairTile(
                            chair: chair[index],
                            seat: seatSelected,
                            onTap: (selectedSeat) {
                              _onSelectedSeat(selectedSeat);
                            })),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFE4E4E4)),
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "Available",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFFADADAD)),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Color(0xFFF6F6F6)),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "Booked",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFFADADAD)),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Color(0xFFFFBD460)),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "Selected",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFFADADAD)),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  ButtonIcon(
                    enabled: seatSelected.isNotEmpty,
                    onTap: () {
                      var seatCodesString =
                          seatSelected.map((seat) => seat.code).join(",");
                      var price = 50000 * seatSelected.length;
                      var fee = 20000 * seatSelected.length;
                      var total = price + fee;
                      var cinemaTickets = CinemaTicket(
                          idOrder: "123",
                          movie: cinemaTicket?.movie,
                          date: cinemaTicket?.date,
                          time: cinemaTicket?.time,
                          cinema: cinemaTicket?.cinema,
                          seatNumber: seatCodesString,
                          price: "Rp. 50.000 x ${seatSelected.length}",
                          fee: "Rp. 20.000 x ${seatSelected.length}",
                          total: total);

                      Navigator.pushNamed(context, '/checkoutMovie',
                          arguments: cinemaTickets);
                      // Navigator.pushNamed(context, '/checkoutMovie');
                    },
                  )
                ],
              ),
            )
          : Container(),
    );
  }

  void _onSelectedSeat(Sheet selectedSeat) {
    setState(() {
      if (seatSelected.contains(selectedSeat)) {
        seatSelected.remove(selectedSeat);
      } else {
        seatSelected.add(selectedSeat);
      }
    });
  }
}
