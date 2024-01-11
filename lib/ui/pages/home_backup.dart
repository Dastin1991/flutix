import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/ui/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MoviePlaying> moviePlaying = [
      MoviePlaying(title: 'Avengers', rating: 7, star: 4, link: ''),
      MoviePlaying(title: 'Fat Dragon', rating: 7, star: 3, link: ''),
      MoviePlaying(title: 'Spiderman', rating: 7, star: 5, link: ''),
    ];
    return (Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 134,
              decoration: const BoxDecoration(
                  color: Color(0xff2C1F63),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 64,
                        width: 64,
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/user_profile.jpeg'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dadang Setiyawan",
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            Text(
                              "IDR 25.000",
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 18,
                                  color: Color(0xFFFBD460)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(title: 'Now Playing'),
                  SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: 3,
                      itemBuilder: (BuildContext context, index) {
                        return (Container(
                          width: 210,
                          height: 140,
                          child: Stack(
                            children: [
                              Container(
                                  width: 210,
                                  height: 140,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/avengers.png',
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                              Column(
                                children: [
                                  Container(
                                    height: 100,
                                    alignment: Alignment.bottomLeft,
                                    padding:
                                        EdgeInsets.only(bottom: 0, left: 16),
                                    child: Text(
                                      "Avengers",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Raleway',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    padding:
                                        EdgeInsets.only(bottom: 10, left: 16),
                                    child: Text(
                                      "Avenger",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Raleway',
                                          fontSize: 14),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ));
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(title: 'Browse Movie'),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/images/ic_action.png'),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Action',
                        style: TextStyle(fontFamily: 'Raleway', fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(title: 'Coming Soon'),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 140,
                        child: Image.asset('assets/images/pikachu.png'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
