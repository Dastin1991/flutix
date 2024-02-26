import 'package:flutix/model/cinema_ticket.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';

class CheckoutMovie extends StatelessWidget {
  final CinemaTicket? cinemaTicket;
  const CheckoutMovie({super.key, this.cinemaTicket});

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
                Header(title: 'Checkout\nMovie'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: const Image(
                              image: AssetImage('assets/images/avengers.png'),
                              width: 70,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cinemaTicket.movie!.title),
                                const Text(
                                  'Action - English',
                                  style: TextStyle(color: Color(0xFFADADAD)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: Color(0xFFE4E4E4),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ID Order',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFFADADAD)),
                          ),
                          Text('22081996')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Cinema',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFFADADAD)),
                          ),
                          Text(cinemaTicket.cinema.toString())
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Date & Time',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFFADADAD)),
                          ),
                          Text("${cinemaTicket.date} ${cinemaTicket.time}")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Seat Number',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFFADADAD)),
                          ),
                          Text(cinemaTicket.seatNumber.toString())
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFFADADAD)),
                          ),
                          Text(cinemaTicket.price.toString())
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Fee',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFFADADAD)),
                          ),
                          Text(cinemaTicket.fee.toString())
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFFADADAD)),
                          ),
                          Text(Utils.format(
                              int.parse(cinemaTicket.total.toString())))
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: Color(0xFFE4E4E4),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Wallet',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFFADADAD)),
                          ),
                          Text(
                            Utils.format(5000000),
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFF3E9D9D)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: SizedBox(
                            width: 250,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff3E9D9D),
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/checkoutSuccess');
                                },
                                child: const Text(
                                  "Checkout Now",
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ))),
                      ),
                    ],
                  ),
                )
              ],
            ))
          : Container(),
    );
  }
}
