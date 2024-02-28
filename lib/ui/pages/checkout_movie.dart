import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutix/model/cinema_ticket.dart';
import 'package:flutix/services/database_services.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutMovie extends StatefulWidget {
  final CinemaTicket? cinemaTicket;
  const CheckoutMovie({super.key, this.cinemaTicket});

  @override
  State<CheckoutMovie> createState() => _CheckoutMovieState();
}

class _CheckoutMovieState extends State<CheckoutMovie> {
  String? orderId;
  String balance = "0";

  @override
  void initState() {
    // TODO: implement initState
    randomNumber();
    getSaldoBalance();
    super.initState();
  }

  void randomNumber() {
    int randomNumber = Utils.generateRandomNumber();
    setState(() {
      orderId = randomNumber.toString();
    });
  }

  Future<void> getSaldoBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('email');

    DocumentSnapshot userSnapshot =
        await DatabaseServices.getUserByEmail(email!);

    if (userSnapshot.exists) {
      // User data found, you can access it using userSnapshot.data()
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      String userFullname = userData['fullname'];
      String userProfile = userData.containsKey('profileImageUrl')
          ? userData['profileImageUrl']
          : '';

      //get saldo balance
      CollectionReference ewalletCollection =
          userSnapshot.reference.collection('ewallet');

      // Get the first document in the ewallet collection
      QuerySnapshot ewalletQuerySnapshot =
          await ewalletCollection.limit(1).get();

      if (ewalletQuerySnapshot.docs.isNotEmpty) {
        // Retrieve the balance field from the first document
        Map<String, dynamic> ewalletData =
            ewalletQuerySnapshot.docs.first.data() as Map<String, dynamic>;
        int userBalance = ewalletData['balance'];
        print(userBalance);
        setState(() {
          balance = Utils.format(userBalance)
              .toString(); // Update the state variable with the retrieved balance
        });
      } else {
        print('No ewallet document found for user with email: $email');
      }
    } else {
      print('User not found for email: $email');
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
