import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/model/ticket.dart';
import 'package:flutix/model/transaction.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionCard extends StatelessWidget {
  final Transactions transactions;
  final Function onTap;

  const TransactionCard(
      {Key? key, required this.transactions, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(transactions.type);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 24),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: (SizedBox(
          width: double.infinity,
          height: 100,
          child: Row(
            children: [
              SizedBox(
                  width: 70,
                  height: 90,
                  child: transactions.type == 'topup'
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/bg_topup.png',
                                fit: BoxFit.cover,
                              ),
                              Center(
                                child: SizedBox(
                                  height: 18,
                                  width: 32,
                                  child: Image.asset(
                                    'assets/images/bg_topup2.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            transactions.link,
                            fit: BoxFit.cover,
                          ),
                        )),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                child: Column(
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
                      Utils.format(transactions.total!),
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: transactions.type == 'topup'
                              ? Color(0xFF3E9D9D)
                              : Color(0xFFFF5C83)),
                    ),
                    Text(
                      transactions.type == 'topup'
                          ? transactions.date!
                          : transactions.cinema!,
                      style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 12,
                          color: Color(0xFFADADAD)),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
