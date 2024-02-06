import 'package:flutix/model/transaction.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutix/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class MyWallet extends StatelessWidget {
  const MyWallet({super.key});

  @override
  Widget build(BuildContext context) {
    List<Transactions> transaction = [
      Transactions(
          id: 1,
          title: 'Avengers: Infinity Wars',
          amount: 'Rp. 650.000',
          description: 'CGV Paris Van Java Mall',
          link: 'assets/images/avengers.png',
          type: 'buy')
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: 'My Wallet'),
            Stack(
              children: [
                const Image(image: AssetImage('assets/images/bg_card.png')),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xFFFFF2CB)),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xFFFBD460)),
                      )
                    ],
                  ),
                ),
                const Positioned(
                    left: 32,
                    top: 100,
                    child: Text(
                      "Rp. 904.592.934",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 28,
                          color: Colors.white),
                    )),
                Positioned(
                    left: 32,
                    bottom: 40,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Card Holder",
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Dadang Setiyawan",
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF3E9D9D),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 36,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Card ID",
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "BWAFLUTIX",
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF3E9D9D),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text("Recent Transactions"),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                      transaction.length,
                      (index) => TransactionCard(
                            transactions: transaction[index],
                            onTap: () {
                              handlerClickTrans(context, transaction[index]);
                            },
                          )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void handlerClickTrans(BuildContext context, Transactions transactions) {
  Navigator.pushNamed(context, '/ticketDetail', arguments: transactions);
}
