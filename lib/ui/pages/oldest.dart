import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutix/model/ticket.dart';
import 'package:flutix/services/database_services.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutix/ui/pages/ticket.dart';
import 'package:flutix/ui/widgets/placeholders.dart';
import 'package:flutix/ui/widgets/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Oldest extends StatefulWidget {
  const Oldest({Key? key}) : super(key: key);

  @override
  State<Oldest> createState() => _OldestState();
}

class _OldestState extends State<Oldest> {
  List<MTicket> tickets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkSharedPreferences();
  }

  Future<void> checkSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('email');

    DocumentSnapshot userSnapshot =
        await DatabaseServices.getUserByEmail(email!);

    if (userSnapshot.exists) {
      // User data found, you can access it using userSnapshot.data()
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      //get saldo balance
      CollectionReference transactionCollection =
          userSnapshot.reference.collection('transactions');

      List<MTicket> trans =
          await getFirestoreTransactions(transactionCollection);

      setState(() {
        tickets = trans;
        isLoading = false;
      });
    } else {
      print('User not found for email: $email');
    }
  }

  Future<List<MTicket>> getFirestoreTransactions(
      CollectionReference transactionCollection) async {
    try {
      DateTime? dateTime;
      String? formattedDate;
      QuerySnapshot transactionsQuerySnapshot =
          await transactionCollection.where('type', isEqualTo: 'movie').get();

      List<MTicket> tickets = transactionsQuerySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Format DateTime to your desired format
        return MTicket(
          title: data['title'],
          genre: 'Action',
          location: data['cinema'],
          link: data['link'],
        );
      }).toList();

      return tickets;
    } catch (error) {
      print('Error retrieving Firestore transactions: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: isLoading
            ? Column(
                children: List.generate(3, (rowIndex) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 1, // Number of placeholders per row
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            // width: 70,
                            // height: 90,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: TransactionPlaceholder(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }))
            : Wrap(
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
