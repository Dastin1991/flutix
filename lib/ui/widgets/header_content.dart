import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HeaderContent extends StatelessWidget {
  final String title;
  HeaderContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 16.0),
      child: (SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            Row(
              children: [
                Container(
                  width: 120,
                  child: Text(
                    title,
                    style: TextStyle(fontFamily: 'Raleway', fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    image: AssetImage('assets/images/avengers.png'),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
