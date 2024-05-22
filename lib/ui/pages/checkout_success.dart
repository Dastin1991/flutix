import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              const SizedBox(
                height: 120,
              ),
              const Image(
                image: AssetImage('assets/images/ic_ticket_buy.png'),
                width: 120,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 90,
              ),
              const Text(
                "Happy Watching!",
                style: TextStyle(fontFamily: 'Raleway', fontSize: 20),
              ),
              const Text(
                "You have successfully\nbought the ticket",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFFADADAD)),
              ),
              const SizedBox(
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
                          context
                              .goNamed('home', queryParameters: {'index': '1'});
                        },
                        child: const Text("My Tickets"))),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Discover new movie?",
                    style: TextStyle(fontSize: 14, color: Color(0xFFADADAD)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.goNamed('home', queryParameters: {'index': '0'});
                    },
                    child: const Text(
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
