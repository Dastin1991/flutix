import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutix/api/api.dart';
import 'package:flutix/model/transaction.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutix/ui/pages/bloc/my_wallet_bloc.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutix/ui/widgets/placeholders.dart';
import 'package:flutix/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  String fullname = "";
  String userId = "";
  String balance = "0";
  String cardId = "BWAFLUTIX";

  String email = "";

  List<Transactions> transaction = [];

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

    String? _email = prefs.getString('email');
    String? _fullname = prefs.getString('fullname');
    // String? _profile_url = prefs.getString('profile_url');

    setState(() {
      email = _email!;
      fullname =
          _fullname!; // Update the state variable with the retrieved fullname
    });

    DocumentSnapshot userSnapshot = await getUserByEmail(email!);

    if (userSnapshot.exists) {
      // User data found, you can access it using userSnapshot.data()
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      //get saldo balance
      CollectionReference ewalletCollection =
          userSnapshot.reference.collection('ewallet');

      //get saldo balance
      CollectionReference transactionCollection =
          userSnapshot.reference.collection('transactions');

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
          userId = userSnapshot.id;
          balance = Utils.format(userBalance)
              .toString(); // Update the state variable with the retrieved balance
          fullname = _fullname!;
          cardId = userCardId;
          // Update the state variable with the retrieved fullname
        });

        List<Transactions> trans =
            await getFirestoreTransactions(transactionCollection);

        setState(() {
          transaction = trans;
        });
      } else {
        print('No ewallet document found for user with email: $email');
      }
    } else {
      print('User not found for email: $email');
    }
  }

  Future<List<Transactions>> getFirestoreTransactions(
      CollectionReference transactionCollection) async {
    try {
      DateTime? dateTime;
      String? formattedDate;
      QuerySnapshot transactionsQuerySnapshot =
          await transactionCollection.get();

      List<Transactions> transactions =
          transactionsQuerySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data['type'] == 'topup') {
          dateTime = data['date'].toDate();
          formattedDate = DateFormat('E, dd MMMM yyyy').format(dateTime!);
        }

        // Format DateTime to your desired format
        return Transactions(
          id: data['id'], // Use document ID as the transaction ID
          title: data['title'],
          amount: data['amount'].toString(),
          description: data['description'],
          link: data['link'],
          type: data['type'],
          cinema: data['cinema'],
          date: formattedDate,
          seat: data['seat'],
          price: data['price'],
          fee: data['fee'],
          total: int.parse(data['total'].toString()),
        );
      }).toList();

      return transactions;
    } catch (error) {
      print('Error retrieving Firestore transactions: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return email != ""
        ? BlocProvider(
            create: (context) =>
                MyWalletBloc(api: Api())..add(LoadMyWallet(email)),
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(title: 'My Wallet'),
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 250,
                          child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/bg_card.png')),
                        ),
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
                              color: Colors.white,
                            ),
                          ),
                        ),
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
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        fullname,
                                        style: const TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width: 14,
                                        height: 14,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF3E9D9D),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
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
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        cardId,
                                        style: const TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width: 14,
                                        height: 14,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF3E9D9D),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
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
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 24.0),
                      child: Text("Recent Transactions"),
                    ),
                    // Expanded(
                    //   child: SingleChildScrollView(
                    //     child: Wrap(
                    //       spacing: 10,
                    //       runSpacing: 10,
                    //       children: List.generate(
                    //         transaction.length,
                    //         (index) => TransactionCard(
                    //           transactions: transaction[index],
                    //           onTap: () {
                    //             handlerClickTrans(context, transaction[index]);
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: BlocBuilder<MyWalletBloc, MyWalletState>(
                        builder: (context, state) {
                          if (state is MyWalletLoading) {
                            return Column(
                                children: List.generate(3, (rowIndex) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 16),
                                child: SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        1, // Number of placeholders per row
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          // width: 70,
                                          // height: 90,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            enabled: true,
                                            child: TransactionPlaceholder(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }));
                          } else if (state is MyWalletLoaded) {
                            final data = state.transaction;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final Transactions _transactions = Transactions(
                                  id: data[index]
                                      .id, // Use document ID as the transaction ID
                                  title: data[index].title,
                                  amount: data[index].total.toString(),
                                  description: data[index].description,
                                  link: data[index].link,
                                  type: data[index].type,
                                  cinema: data[index].cinema,
                                  date: data[index].cinema,
                                  seat: data[index].seat,
                                  price: data[index].price,
                                  fee: data[index].fee,
                                  total: data[index].total,
                                );
                                return GestureDetector(
                                  child: TransactionCard(
                                    onTap: () {
                                      handlerClickTrans(context, data[index]);
                                    },
                                    transactions: _transactions,
                                  ),
                                );
                              },
                            );
                          } else {
                            return Container(); // Handle other states if needed
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}

void handlerClickTrans(BuildContext context, Transactions transactions) {
  print(transactions.date);
  if (transactions.type != 'topup')
    Navigator.pushNamed(context, '/ticketDetail', arguments: transactions);
}
