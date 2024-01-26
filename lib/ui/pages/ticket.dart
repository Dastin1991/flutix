import 'package:flutix/ui/pages/newest.dart';
import 'package:flutix/ui/pages/oldest.dart';
import 'package:flutter/material.dart';

class Ticket extends StatelessWidget {
  const Ticket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('My Tickets'),
          backgroundColor: Color(0xff2C1F63),
          foregroundColor: Colors.white,
          centerTitle: false,
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.amber,
            tabs: <Widget>[
              Tab(
                text: "Newest",
              ),
              Tab(
                text: "Oldest",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[Newest(), Oldest()],
        ),
      ),
    );
  }
}
