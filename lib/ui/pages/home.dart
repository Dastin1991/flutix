import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutix/api/api.dart';
import 'package:flutix/model/lucky_day.dart';
import 'package:flutix/model/movie_model.dart';
import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/services/utils.dart';
import 'package:flutix/ui/pages/bloc/home_bloc.dart';
import 'package:flutix/ui/widgets/category_card.dart';
import 'package:flutix/ui/widgets/comingsoon_card.dart';
import 'package:flutix/ui/widgets/lucky_day_card.dart';
import 'package:flutix/ui/widgets/movie_card.dart';
import 'package:flutix/ui/widgets/placeholders.dart';
import 'package:flutix/ui/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fullname = "";
  String balance = "0";
  String profile_url = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
    checkSharedPreferences();
  }

  Future<DocumentSnapshot> getUserByEmail(String email) async {
    // Reference to the "users" collection in Firestore
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Query for the user document with the provided email
    QuerySnapshot querySnapshot =
        await usersCollection.where('email', isEqualTo: email).get();

    // Check if the query returned any documents
    if (querySnapshot.docs.isNotEmpty) {
      // Return the first document found (assuming email is unique)
      return querySnapshot.docs.first;
    } else {
      // Handle the case where no user with the provided email was found
      throw Exception('User not found for email: $email');
    }
  }

  Future<void> checkSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('email');
    String? _fullname = prefs.getString('fullname');
    // String? _profile_url = prefs.getString('profile_url');

    setState(() {
      fullname =
          _fullname!; // Update the state variable with the retrieved fullname
    });

    DocumentSnapshot userSnapshot = await getUserByEmail(email!);

    if (userSnapshot.exists) {
      // User data found, you can access it using userSnapshot.data()
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      String userFullname = userData['fullname'];
      String userProfile = userData.containsKey('profileImageUrl')
          ? userData['profileImageUrl']
          : '';

      //get saldo balance
      CollectionReference ewalletCollection =
          userSnapshot.reference.collection('ewallet');

      // Get the first document in the ewallet collection
      QuerySnapshot ewalletQuerySnapshot =
          await ewalletCollection.limit(1).get();

      if (ewalletQuerySnapshot.docs.isNotEmpty) {
        // Retrieve the balance field from the first document
        Map<String, dynamic> ewalletData =
            ewalletQuerySnapshot.docs.first.data() as Map<String, dynamic>;
        int userBalance = ewalletData['balance'];

        setState(() {
          balance = Utils.format(userBalance)
              .toString(); // Update the state variable with the retrieved balance
          fullname = _fullname!;
          profile_url =
              userProfile; // Update the state variable with the retrieved fullname
        });

        await prefs.setString('profileUrl', userProfile);
      } else {
        print('No ewallet document found for user with email: $email');
      }
    } else {
      print('User not found for email: $email');
    }
  }

  Future<void> initPlatformState() async {
    // await StatusBarControl.setColor(Colors.green, animated: true);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
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
    return (BlocProvider(
      create: (context) => HomeBloc(api: Api())..add(LoadHome()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30),
                width: double.infinity,
                height: 144,
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
                        SizedBox(
                          height: 64,
                          width: 64,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                            child: profile_url.isNotEmpty
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(profile_url),
                                  )
                                : const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/user_pic.png')),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$fullname",
                                style: const TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              Text(
                                balance.toString(),
                                style: const TextStyle(
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
                        // scrollDirection: Axis.horizontal,
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is HomeLoading) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 140,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 3, // Number of banners
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 210,
                                            height: 140,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                                  Colors.grey.shade100,
                                              enabled: true,
                                              child: BannerPlaceholder(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            } else if (state is HomeLoaded) {
                              final data = state.movies;
                              return SizedBox(
                                width: 500,
                                height: 140,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      final double rating = data[index].rating;

// Format the rating with one decimal place and comma separator
                                      final NumberFormat formatter =
                                          NumberFormat("#,##0.0", "en_US");
                                      final formattedRating =
                                          formatter.format(rating);
                                      final MoviePlaying movie = MoviePlaying(
                                          title: data[index].title,
                                          rating: double.parse(formattedRating),
                                          star: 5,
                                          overview: data[index].overview,
                                          link:
                                              "https://image.tmdb.org/t/p/original${data[index].posterPath}");
                                      return MovieCard(
                                        movie: movie,
                                        onTap: () {
                                          handlerClickMovie(context, movie);
                                        },
                                      );
                                    }),
                              );
                            } else if (state is HomeError) {
                              return Center(child: Text(state.error));
                            }
                            return Container();
                          },
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
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoading) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 140,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 100,
                                          height: 140,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            enabled: true,
                                            child: ComingSoonPlaceholder(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else if (state is HomeLoaded) {
                            final data = state.upcoming;
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final MoviePlaying movie = MoviePlaying(
                                        title: data[index].title,
                                        rating: data[index].rating,
                                        star: 5,
                                        overview: data[index].overview,
                                        link:
                                            "https://image.tmdb.org/t/p/original${data[index].posterPath}");
                                    return ComingsoonCard(
                                      movie: movie,
                                      // onTap: () {
                                      //   handlerClickMovie(context, movie);
                                      // }
                                    );
                                  }),
                            );
                          } else if (state is HomeError) {
                            return Center(child: Text(state.error));
                          }
                          return Container();
                        },
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
      ),
    ));
  }
}

void handlerClickMovie(BuildContext context, MoviePlaying movie) {
  Navigator.pushNamed(context, '/movieDetail', arguments: movie);
}
