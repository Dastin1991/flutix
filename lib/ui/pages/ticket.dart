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
          title: const Text('My Tickets'),
          backgroundColor: Color(0xff2C1F63),
          centerTitle: false,
          bottom: const TabBar(
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
