import 'package:flutix/ui/pages/home.dart';
import 'package:flutix/ui/pages/ticket.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Menu extends StatefulWidget {
  int selectedIndex = 0;
  Menu({required this.selectedIndex});

  @override
  State<Menu> createState() => _MenuState(selectedIndex);
}

class _MenuState extends State<Menu> {
  int _selectedIndex;
  _MenuState(this._selectedIndex);

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Ticket(),
  ];
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FloatingActionButton(
            onPressed: () {
              context.goNamed('topup');
            },
            backgroundColor: Colors.amber[500],
            child: const Icon(Icons.download),
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: _selectedIndex == 0
                              ? AssetImage('assets/images/ic_movies.png')
                              : AssetImage('assets/images/ic_movies_grey.png'),
                          width: 24,
                          height: 18,
                        ),
                        Text(
                          "New Movies",
                          style: TextStyle(
                              color: _selectedIndex == 0
                                  ? Color(0xFF000000)
                                  : Color(0xFFE0E0E0)),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    }),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: _selectedIndex == 1
                              ? const AssetImage('assets/images/ic_tickets.png')
                              : const AssetImage(
                                  'assets/images/ic_movies_gray_ticket.png'),
                          width: 24,
                          height: 18,
                        ),
                        Text(
                          "My Tickets",
                          style: TextStyle(
                              color: _selectedIndex == 1
                                  ? Color(0xFF000000)
                                  : Color(0xFFE0E0E0)),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        )));
  }
}
