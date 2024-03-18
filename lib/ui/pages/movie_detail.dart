import 'package:flutix/api/api.dart';
import 'package:flutix/model/crew.dart';
import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/ui/pages/bloc/movie_detail_bloc.dart';
import 'package:flutix/ui/widgets/crew_card.dart';
import 'package:flutix/ui/widgets/placeholders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetail extends StatefulWidget {
  final MoviePlaying? movie;

  const MovieDetail({Key? key, this.movie}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;
    MoviePlaying? movie;

    List<Crew> crew = [
      Crew(name: 'Robbie Maggot', profile: 'assets/images/crew_1.png'),
      Crew(name: 'Robert Downey Jr', profile: 'assets/images/crew_2.png'),
      Crew(name: 'Chris Hemsworth', profile: 'assets/images/crew_3.png'),
      Crew(name: 'Josh Thanos', profile: 'assets/images/crew_4.png'),
      Crew(name: 'Tom Holland', profile: 'assets/images/crew_5.png'),
    ];

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'qQ1hpNh24Wo',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    if (arg is MoviePlaying) {
      movie = arg;
    }

    return BlocProvider(
      create: (context) =>
          MovieDetailBloc(api: Api())..add(LoadMovieDetail('1011985')),
      child: SafeArea(
        child: (Scaffold(
          body: movie != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: double.infinity,
                          height: 270,
                          child: Image.network(
                            movie.link,
                            fit: BoxFit.fill,
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                              fontFamily: 'Raleway', fontSize: 24),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Action - English",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 12,
                              color: Color(0xFFADADAD)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Wrap(
                              children: List.generate(
                                  1,
                                  (index) => Icon(
                                        Icons.star,
                                        color: index < movie!.star
                                            ? Colors.yellow
                                            : Color(0xFFC4C4C4),
                                      )),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${movie.rating}/10',
                            style: TextStyle(color: Color(0xFFC4C4C4)),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Cast & Crew",
                              style: TextStyle(
                                  fontFamily: 'Raleway', fontSize: 14),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 140,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: List.generate(
                                      crew.length,
                                      (index) => CrewCard(
                                            crew: crew[index],
                                            onTap: () {},
                                          )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Storyline",
                              style: TextStyle(
                                  fontFamily: 'Raleway', fontSize: 14),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              movie.overview!,
                              style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 14,
                                  color: Color(0xFFADADAD)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Trailer",
                              style: TextStyle(
                                  fontFamily: 'Raleway', fontSize: 14),
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            BlocBuilder<MovieDetailBloc, MovieDetailState>(
                              builder: (context, state) {
                                if (state is MovieDetailLoading) {
                                  return Column(
                                      children: List.generate(3, (rowIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, top: 16),
                                      child: SizedBox(
                                        height: 100,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              1, // Number of placeholders per row
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                // width: 70,
                                                // height: 90,
                                                child: Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  enabled: true,
                                                  child:
                                                      const TransactionPlaceholder(),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }));
                                } else if (state is MovieDetailLoaded) {
                                  final data = state.movieTrailers;
                                  return ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        child: YoutubePlayer(
                                          controller: _controller,
                                          showVideoProgressIndicator: true,
                                          progressIndicatorColor: Colors.amber,
                                          progressColors:
                                              const ProgressBarColors(
                                            playedColor: Colors.amber,
                                            handleColor: Colors.amberAccent,
                                          ),
                                          // onReady: () {
                                          //   _controller.addListener(listener);
                                          // },
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container(); // Handle other states if needed
                                }
                              },
                            )
                            // YoutubePlayer(
                            //   controller: _controller,
                            //   showVideoProgressIndicator: true,
                            //   progressIndicatorColor: Colors.amber,
                            //   progressColors: const ProgressBarColors(
                            //     playedColor: Colors.amber,
                            //     handleColor: Colors.amberAccent,
                            //   ),
                            //   // onReady: () {
                            //   //   _controller.addListener(listener);
                            //   // },
                            // ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 250,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff503E9D),
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/chooseDate',
                                      arguments: movie);
                                },
                                child: const Text("Continue to Book"))),
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                )
              : Container(),
        )),
      ),
    );
  }
}
