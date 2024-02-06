import 'package:flutix/model/topup.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutix/ui/widgets/topup_tile.dart';
import 'package:flutter/material.dart';

class TopUp extends StatelessWidget {
  const TopUp({super.key});

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
              const TextField(
                decoration: InputDecoration(
                    labelText: "Amount", border: OutlineInputBorder()),
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
                        selected: false,
                        onTap: () {})),
              ),
              SizedBox(
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
                          Navigator.pushNamed(context, '/topupSuccess');
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
}
