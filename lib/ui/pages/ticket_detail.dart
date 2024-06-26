import 'package:flutix/model/crew.dart';
import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/model/transaction.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutix/ui/widgets/crew_card.dart';
import 'package:flutter/material.dart';

class TicketDetail extends StatelessWidget {
  final Transactions? transactions;

  const TicketDetail({Key? key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: const Text("Ticket Detail")),
      body: transactions != null
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: 270,
                        child: Image(
                          image: NetworkImage(transactions!.link),
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions!.title,
                            style: const TextStyle(
                                fontFamily: 'Raleway', fontSize: 24),
                          ),
                          const Text(
                            "Action - English",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 12,
                                color: Color(0xFFADADAD)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Cinema',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    color: Color(0xFFADADAD)),
                              ),
                              Text(transactions!.cinema!)
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
                              Text(transactions!.date!)
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
                              Text(transactions!.seat!)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'ID Order',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    color: Color(0xFFADADAD)),
                              ),
                              Text(transactions!.id!.toString())
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Name',
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        color: Color(0xFFADADAD)),
                                  ),
                                  const Text('Dadang Setiyawan'),
                                  const Text(
                                    'Paid',
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        color: Color(0xFFADADAD)),
                                  ),
                                  Text(Utils.format(transactions!.total!))
                                ],
                              ),
                              const Image(
                                  image: AssetImage('assets/images/qrcode.png'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    ));
  }
}
