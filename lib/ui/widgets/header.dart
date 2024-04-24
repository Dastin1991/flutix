import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Header extends StatelessWidget {
  final String title;
  Header({required this.title});

  @override
  Widget build(BuildContext context) {
    return (SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                Center(
                  child: SizedBox(
                    // width: 200,
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
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
