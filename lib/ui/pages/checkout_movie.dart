import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutix/model/cinema_ticket.dart';
import 'package:flutix/model/transaction.dart';
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

  Future<void> createTicket(Transactions transactions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('email');
    final firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot userSnapshot = await getUserByEmail(email!);
      if (userSnapshot.exists) {
        // User exists, perform transaction to create subcollection
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
          print("User and wallet added successfully");

          //get saldo balance
          CollectionReference ewalletCollection =
              userSnapshot.reference.collection('ewallet');

          // Get the first document in the ewallet collection
          QuerySnapshot ewalletQuerySnapshot =
              await ewalletCollection.limit(1).get();

          if (ewalletQuerySnapshot.docs.isNotEmpty) {
            // Get the reference to the first document in the ewallet collection
            DocumentReference ewalletDocRef =
                ewalletQuerySnapshot.docs.first.reference;

            // Get the current balance from the ewallet document
            Map<String, dynamic> ewalletData =
                ewalletQuerySnapshot.docs.first.data() as Map<String, dynamic>;
            int currentBalance = ewalletData['balance'] ?? 0;

            // Subtract 10000 from the current balance
            int newBalance = currentBalance - transactions.total!;

            // Update the balance field in the ewallet document
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
    } catch (e) {
      print("Some error occured");
    }
  }

  Future<DocumentSnapshot> getUserByEmail(String email) async {
    // Reference to the "users" collection in Firestore
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Query for the user document with the provided email
    QuerySnapshot querySnapshot =
        await usersCollection.where('email', isEqualTo: email).get();

    // Check if the query returned any documents
    if (querySnapshot.docs.isNotEmpty) {
      // Return the first document found (assuming email is unique)
      return querySnapshot.docs.first;
    } else {
      // Handle the case where no user with the provided email was found
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
                                  final Transactions trans = Transactions(
                                    id: int.parse(orderId!),
                                    title: cinemaTicket!.movie!.title,
                                    amount: cinemaTicket.total.toString(),
                                    description:
                                        cinemaTicket.movie!.overview.toString(),
                                    link: cinemaTicket.movie!.link,
                                    type: "movie",
                                    cinema: cinemaTicket.cinema,
                                    date: cinemaTicket.date,
                                    seat: cinemaTicket.seatNumber,
                                    price: cinemaTicket.price!,
                                    fee: cinemaTicket.fee!,
                                    total: int.parse(cinemaTicket.total!),
                                  );
                                  createTicket(trans);
                                  // Navigator.pushNamed(
                                  //     context, '/checkoutSuccess');
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
