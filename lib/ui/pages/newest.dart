import 'package:flutix/model/ticket.dart';
import 'package:flutix/ui/pages/ticket.dart';
import 'package:flutix/ui/widgets/ticket_card.dart';
import 'package:flutter/material.dart';

class Newest extends StatelessWidget {
  const Newest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MTicket> tickets = [
      MTicket(
          title: 'Avengers',
          genre: 'Action',
          location: 'Bandung',
          link: 'assets/images/avengers.png'),
      MTicket(
          title: 'Fat Dragon',
          genre: 'Action',
          location: 'Bandung',
          link: 'assets/images/deadpool.png'),
    ];
    return (Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
              tickets.length,
              (index) => TicketCard(
                    ticket: tickets[index],
                  )),
        ),
      ),
    ));
  }
}
