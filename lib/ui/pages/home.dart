import 'package:flutix/model/lucky_day.dart';
import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/ui/widgets/category_card.dart';
import 'package:flutix/ui/widgets/comingsoon_card.dart';
import 'package:flutix/ui/widgets/lucky_day_card.dart';
import 'package:flutix/ui/widgets/movie_card.dart';
import 'package:flutix/ui/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // await StatusBarControl.setColor(Colors.green, animated: true);
  }

  @override
  Widget build(BuildContext context) {
    List<MoviePlaying> moviePlaying = [
      MoviePlaying(
          title: 'Avengers',
          rating: 7,
          star: 4,
          link: 'assets/images/avengers.png'),
      MoviePlaying(
          title: 'Fat Dragon',
          rating: 7,
          star: 3,
          link: 'assets/images/deadpool.png'),
    ];

    List<MoviePlaying> comingsoon = [
      MoviePlaying(
          title: 'Avengers',
          rating: 7,
          star: 4,
          link: 'assets/images/pikachu.png'),
      MoviePlaying(
          title: 'Fat Dragon',
          rating: 7,
          star: 3,
          link: 'assets/images/spiderman.png'),
      MoviePlaying(
          title: 'Avengers',
          rating: 7,
          star: 4,
          link: 'assets/images/pikachu.png'),
      MoviePlaying(
          title: 'Fat Dragon',
          rating: 7,
          star: 3,
          link: 'assets/images/spiderman.png'),
    ];

    List<MoviePlaying> category = [
      MoviePlaying(
          title: 'Action',
          rating: 7,
          star: 4,
          link: 'assets/images/ic_action.png'),
      MoviePlaying(
          title: 'War', rating: 7, star: 3, link: 'assets/images/ic_war.png'),
      MoviePlaying(
          title: 'Drama',
          rating: 7,
          star: 3,
          link: 'assets/images/ic_drama.png'),
      MoviePlaying(
          title: 'Music',
          rating: 7,
          star: 3,
          link: 'assets/images/ic_music.png'),
    ];
    List<LuckyDay> luckyDay = [
      LuckyDay(
          title: 'Student Holiday',
          description: 'Maximal only for two people',
          discount: 50),
      LuckyDay(
          title: 'Family Club',
          description: 'Minimal for three members',
          discount: 70),
      LuckyDay(
          title: 'Student Holiday',
          description: 'Maximal only for two people',
          discount: 50),
    ];
    return SafeArea(
      child: (Scaffold(
        body: SingleChildScrollView(
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
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 64,
                          width: 64,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/user_profile.jpeg'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
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
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustom(title: 'Now Playing'),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 140,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(
                              moviePlaying.length,
                              (index) => MovieCard(
                                    movie: moviePlaying[index],
                                    onTap: () {
                                      handlerClickMovie(
                                          context, moviePlaying[index]);
                                    },
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustom(title: 'Browse Movie'),
                    const SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                          category.length,
                          (index) => CategoryCard(
                                movie: category[index],
                              )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustom(title: 'Coming Soon'),
                    const SizedBox(
                      height: 12,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                            comingsoon.length,
                            (index) => ComingsoonCard(
                                  movie: comingsoon[index],
                                )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustom(title: 'Get Lucky Day'),
                    const SizedBox(
                      height: 12,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        runSpacing: 8,
                        children: List.generate(
                            luckyDay.length,
                            (index) => LuckyDayCard(
                                  luckyDay: luckyDay[index],
                                )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

void handlerClickMovie(BuildContext context, MoviePlaying movie) {
  Navigator.pushNamed(context, '/movieDetail', arguments: movie);
}
