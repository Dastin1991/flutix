import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HeaderContent extends StatelessWidget {
  final String title;
  HeaderContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return (SizedBox(
      height: 50,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          Container(
            padding: const EdgeInsets.only(left: 40),
            child: SizedBox(
              width: 180,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
