import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutix/model/transaction.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutix/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  String fullname = "";
  String balance = "0";
  String cardId = "BWAFLUTIX";

  @override
  void initState() {
    super.initState();
    checkSharedPreferences();
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

  Future<void> checkSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('email');
    String? _fullname = prefs.getString('fullname');
    // String? _profile_url = prefs.getString('profile_url');

    setState(() {
      fullname =
          _fullname!; // Update the state variable with the retrieved fullname
    });

    DocumentSnapshot userSnapshot = await getUserByEmail(email!);

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
        String userCardId = ewalletData['cardId'];

        setState(() {
          balance = Utils.format(userBalance)
              .toString(); // Update the state variable with the retrieved balance
          fullname = _fullname!;
          cardId = userCardId;
          // Update the state variable with the retrieved fullname
        });

        await prefs.setString('profileUrl', userProfile);
      } else {
        print('No ewallet document found for user with email: $email');
      }
    } else {
      print('User not found for email: $email');
    }
  }

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
                Positioned(
                    left: 32,
                    top: 100,
                    child: Text(
                      balance,
                      style: const TextStyle(
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
                                Text(
                                  fullname,
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
                                Text(
                                  cardId,
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
