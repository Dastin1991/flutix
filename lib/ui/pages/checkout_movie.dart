import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutix/model/cinema_ticket.dart';
import 'package:flutix/model/transaction.dart';
import 'package:flutix/services/database_services.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutMovie extends StatefulWidget {
  final CinemaTicket? cinemaTicket;
  const CheckoutMovie({Key? key, this.cinemaTicket}) : super(key: key);

  @override
  State<CheckoutMovie> createState() => _CheckoutMovieState();
}

class _CheckoutMovieState extends State<CheckoutMovie> {
  String? orderId;
  String balance = "0";
  int? totalCost = 0;
  int? userBalance = 0;
  bool isLowBalance = false;

  @override
  void initState() {
    super.initState();
    if (widget.cinemaTicket != null) {
      totalCost = widget.cinemaTicket!.total;
      randomNumber();
      getSaldoBalance();
    }
  }

  void randomNumber() {
    int randomNumber = Utils.generateRandomNumber();
    setState(() {
      orderId = randomNumber.toString();
    });
  }

  Future<void> getSaldoBalance() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');

      DocumentSnapshot userSnapshot =
          await DatabaseServices.getUserByEmail(email!);

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        CollectionReference ewalletCollection =
            userSnapshot.reference.collection('ewallet');

        QuerySnapshot ewalletQuerySnapshot =
            await ewalletCollection.limit(1).get();

        if (ewalletQuerySnapshot.docs.isNotEmpty) {
          Map<String, dynamic> ewalletData =
              ewalletQuerySnapshot.docs.first.data() as Map<String, dynamic>;
          int userBalance = ewalletData['balance'];
          setState(() {
            userBalance = userBalance;
            balance = Utils.format(userBalance).toString();
          });

          if (userBalance < totalCost!) {
            showToast();
            setState(() {
              isLowBalance = true;
            });
          }
        } else {
          print('No ewallet document found for user with email: $email');
        }
      } else {
        print('User not found for email: $email');
      }
    } catch (error) {
      print('Error fetching balance: $error');
    }
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: 'You need to top up your wallet first',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Color(0xFFFF5C83),
      textColor: Colors.white,
    );
  }

  Future<void> createTicket(Transactions transactions) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');
      final firestore = FirebaseFirestore.instance;

      DocumentSnapshot userSnapshot = await getUserByEmail(email!);

      if (userSnapshot.exists) {
        final String userId = userSnapshot.id;

        CollectionReference users = firestore.collection("users");

        users.doc(userId).collection('transactions').add({
          'id': transactions.id,
          'title': transactions.title,
          'description': transactions.description,
          'link': transactions.link,
          'type': transactions.type,
          'cinema': transactions.cinema,
          'date': transactions.date,
          'seat': transactions.seat,
          'price': transactions.price,
          'fee': transactions.fee,
          'total': transactions.total
        }).then((_) async {
          CollectionReference ewalletCollection =
              userSnapshot.reference.collection('ewallet');

          QuerySnapshot ewalletQuerySnapshot =
              await ewalletCollection.limit(1).get();

          if (ewalletQuerySnapshot.docs.isNotEmpty) {
            DocumentReference ewalletDocRef =
                ewalletQuerySnapshot.docs.first.reference;

            Map<String, dynamic> ewalletData =
                ewalletQuerySnapshot.docs.first.data() as Map<String, dynamic>;
            int currentBalance = ewalletData['balance'] ?? 0;

            int newBalance = currentBalance - transactions.total!;
            await ewalletDocRef.update({
              'balance': newBalance,
            });

            print('Balance updated successfully. New balance: $newBalance');
          } else {
            print('No ewallet document found for user with email: $email');
          }
          Navigator.pushNamedAndRemoveUntil(
              context, '/checkoutSuccess', (route) => false);
        }).catchError((error) {
          print("Failed to add wallet: $error");
        });
      }
    } catch (error) {
      print('Error creating ticket: $error');
    }
  }

  Future<DocumentSnapshot> getUserByEmail(String email) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot =
        await usersCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      throw Exception('User not found for email: $email');
    }
  }

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
                              child: Image(
                                image: NetworkImage(cinemaTicket.movie!.link),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ID Order',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: Color(0xFFADADAD)),
                            ),
                            Text(orderId!)
                          ],
                        ),
                        // Other rows...
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
                              balance,
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
                            child: !isLowBalance
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff3E9D9D),
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      final Transactions trans = Transactions(
                                        id: int.parse(orderId!),
                                        title: cinemaTicket!.movie!.title,
                                        amount: cinemaTicket.total.toString(),
                                        description: cinemaTicket
                                            .movie!.overview
                                            .toString(),
                                        link: cinemaTicket.movie!.link,
                                        type: "movie",
                                        cinema: cinemaTicket.cinema,
                                        date: cinemaTicket.date,
                                        seat: cinemaTicket.seatNumber,
                                        price: cinemaTicket.price!,
                                        fee: cinemaTicket.fee!,
                                        total: cinemaTicket.total!,
                                      );
                                      createTicket(trans);
                                    },
                                    child: const Text(
                                      "Checkout Now",
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff503E9D),
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/topup');
                                    },
                                    child: const Text("Top Up My Wallet"),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
