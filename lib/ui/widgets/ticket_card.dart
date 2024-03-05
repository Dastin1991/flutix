import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/model/ticket.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final MTicket ticket;
  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 24),
      child: (SizedBox(
        width: double.infinity,
        height: 90,
        child: Row(
          children: [
            SizedBox(
                width: 70,
                height: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    ticket.link,
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ticket.title,
                  style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  ticket.genre,
                  style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 12,
                      color: Color(0xFFADADAD)),
                ),
                Text(
                  ticket.location,
                  style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 12,
                      color: Color(0xFFADADAD)),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
