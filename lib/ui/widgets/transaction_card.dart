import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/model/ticket.dart';
import 'package:flutix/model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final Transactions transactions;
  const TransactionCard({Key? key, required this.transactions})
      : super(key: key);

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
                  child: Image.asset(
                    transactions.link,
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
                  transactions.title,
                  style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  transactions.amount,
                  style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 12,
                      color: Color(0xFFADADAD)),
                ),
                Text(
                  transactions.description,
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
