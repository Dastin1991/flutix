import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutix/model/topup.dart';
import 'package:flutix/services/database_services.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutix/ui/widgets/loading_modal.dart';
import 'package:flutix/ui/widgets/topup_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key});

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  List<int> selectedTopUp = <int>[];
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<TopUpClass> topUp = [
      TopUpClass(nominal: 50000),
      TopUpClass(nominal: 100000),
      TopUpClass(nominal: 150000),
      TopUpClass(nominal: 200000),
      TopUpClass(nominal: 250000),
      TopUpClass(nominal: 500000),
      TopUpClass(nominal: 1000000),
      TopUpClass(nominal: 2500000),
      TopUpClass(nominal: 5000000),
    ];

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: 'Top Up'),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                    labelText: "Amount", border: OutlineInputBorder()),
                onChanged: (value) {
                  // Check if the TextField is empty
                  if (value.isNotEmpty) {
                    // Update the TextField with the selected nominal value
                    _onSelectedTopUp(int.parse(value));
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Choose by Template'),
              const SizedBox(
                height: 8,
              ),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                direction: Axis.horizontal,
                children: List.generate(
                    topUp.length,
                    (index) => TopUpTile(
                        title: topUp[index].nominal,
                        selected: selectedTopUp.contains(topUp[index].nominal)
                            ? true
                            : false,
                        onTap: () {
                          _onSelectedTopUp(topUp[index].nominal);
                        })),
              ),
              const SizedBox(
                height: 250,
              ),
              Center(
                child: SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff3E9D9D),
                            foregroundColor: Colors.white),
                        onPressed: () {
                          if (amountController.text.isNotEmpty) {
                            showCustomDialog(context);
                            topUpBalance(int.parse(amountController.text));
                          }
                        },
                        child: const Text(
                          "Top Up Now",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectedTopUp(int nominal) {
    amountController.text = nominal.toString();
    setState(() {
      selectedTopUp = [];
      selectedTopUp.add(nominal);
    });
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingModal();
      },
    );
  }

  Future<void> topUpBalance(int nominal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('email');

    try {
      final firestore = FirebaseFirestore.instance;
      DocumentSnapshot userSnapshot =
          await DatabaseServices.getUserByEmail(email!);

      if (userSnapshot.exists) {
        // User exists, perform transaction to create subcollection
        final String userId = userSnapshot.id;
        int randomNumber = Utils.generateRandomNumber();
        DateTime dateTime = DateTime.now();
        CollectionReference users = firestore.collection("users");

        users.doc(userId).collection('transactions').add({
          'id': randomNumber,
          'title': 'Top Up Ewallet',
          'description': '',
          'link': '',
          'type': '',
          'cinema': '',
          'date': dateTime,
          'seat': '',
          'price': '',
          'fee': '',
          'type': 'topup',
          'total': amountController.text,
          'created_dt': dateTime
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
            int newBalance = currentBalance + int.parse(amountController.text);

            // Update the balance field in the ewallet document
            await ewalletDocRef.update({
              'balance': newBalance,
            });

            print('Balance updated successfully. New balance: $newBalance');
          } else {
            print('No ewallet document found for user with email: $email');
          }

          Navigator.of(context).pop();
          Navigator.pushNamedAndRemoveUntil(
              context, '/topupSuccess', (route) => false);
        }).catchError((error) {
          print("Failed to add wallet: $error");
        });
      }
    } catch (e) {
      print("Some error occured");
    }
  }
}
