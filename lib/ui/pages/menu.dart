import 'package:flutix/ui/pages/home.dart';
import 'package:flutix/ui/pages/ticket.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Ticket(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.amber[500],
          child: const Icon(Icons.download),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomAppBar(
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
                              ? AssetImage('assets/images/ic_tickets.png')
                              : AssetImage(
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
        )

        // BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       activeIcon: SizedBox(
        //           width: 24,
        //           height: 18,
        //           child: Image(image: AssetImage('assets/images/ic_movies.png'))),
        //       icon: SizedBox(
        //           width: 24,
        //           height: 18,
        //           child: Image(
        //               image: AssetImage('assets/images/ic_movies_grey.png'))),
        //       label: 'New Movies',
        //     ),
        //     BottomNavigationBarItem(
        //       activeIcon: SizedBox(
        //           width: 24,
        //           height: 18,
        //           child:
        //               Image(image: AssetImage('assets/images/ic_tickets.png'))),
        //       icon: SizedBox(
        //           width: 24,
        //           height: 18,
        //           child: Image(
        //               image:
        //                   AssetImage('assets/images/ic_movies_gray_ticket.png'))),
        //       label: 'My Tickets',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Color(0xff2C1F63),
        //   onTap: _onItemTapped,
        // ),
        ));
  }
}
