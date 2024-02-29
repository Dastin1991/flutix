import 'package:flutter/material.dart';

class CheckoutSuccess extends StatelessWidget {
  const CheckoutSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
              Image(
                image: AssetImage('assets/images/ic_ticket_buy.png'),
                width: 120,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 90,
              ),
              Text(
                "Happy Watching!",
                style: TextStyle(fontFamily: 'Raleway', fontSize: 20),
              ),
              Text(
                "You have successfully\nbought the ticket",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFFADADAD)),
              ),
              SizedBox(
                height: 80,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff503E9D),
                            foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                            arguments: {'selectedIndex': 1},
                          );
                        },
                        child: const Text("My Tickets"))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Discover new movie?",
                    style: TextStyle(fontSize: 14, color: Color(0xFFADADAD)),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    },
                    child: Text(
                      "Back to Home",
                      style: TextStyle(fontSize: 14, color: Color(0xFF503E9D)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
