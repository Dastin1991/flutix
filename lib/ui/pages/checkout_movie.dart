import 'package:flutix/ui/widgets/custom_painter.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';

class CheckoutMovie extends StatelessWidget {
  const CheckoutMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Header(title: 'Checkout\nMovie'),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: AssetImage('assets/images/avengers.png'),
                        width: 70,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Avengers: Infinity Wars'),
                          Text(
                            'Action - English',
                            style: TextStyle(color: Color(0xFFADADAD)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: Color(0xFFE4E4E4),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ID Order',
                      style: TextStyle(
                          fontFamily: 'Raleway', color: Color(0xFFADADAD)),
                    ),
                    Text('22081996')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cinema',
                      style: TextStyle(
                          fontFamily: 'Raleway', color: Color(0xFFADADAD)),
                    ),
                    Text('Paris Van Java')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date & Time',
                      style: TextStyle(
                          fontFamily: 'Raleway', color: Color(0xFFADADAD)),
                    ),
                    Text('Sat 21, 12:20')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Seat Number',
                      style: TextStyle(
                          fontFamily: 'Raleway', color: Color(0xFFADADAD)),
                    ),
                    Text('B3, B4')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                          fontFamily: 'Raleway', color: Color(0xFFADADAD)),
                    ),
                    Text('Rp. 40.000 x 2')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fee',
                      style: TextStyle(
                          fontFamily: 'Raleway', color: Color(0xFFADADAD)),
                    ),
                    Text('Rp. 20.000 x2')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                          fontFamily: 'Raleway', color: Color(0xFFADADAD)),
                    ),
                    Text('Rp. 50.000.000')
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: Color(0xFFE4E4E4),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Wallet',
                      style: TextStyle(
                          fontFamily: 'Raleway', color: Color(0xFFADADAD)),
                    ),
                    Text(
                      'Rp. 500.000.000',
                      style: TextStyle(
                          fontFamily: 'Raleway', color: Color(0xFF3E9D9D)),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
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
                            Navigator.pushNamed(context, '/checkoutSuccess');
                          },
                          child: const Text(
                            "Checkout Now",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ))),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
