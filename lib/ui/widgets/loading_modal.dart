import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.white, // Background color set to white
        padding: EdgeInsets.all(8.0),
        child: Center(
          child:
              Lottie.asset('assets/animations/loading1.json', fit: BoxFit.fill),
        ),
      ),
    );
  }
}
