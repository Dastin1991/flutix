import 'package:flutix/model/crew.dart';
import 'package:flutix/model/movie_playing.dart';
import 'package:flutix/ui/widgets/crew_card.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final MoviePlaying? movie;

  const MovieDetail({Key? key, this.movie}) : super(key: key);

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

    if (arg is MoviePlaying) {
      movie = arg;
    }
    return SafeArea(
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
                            style:
                                TextStyle(fontFamily: 'Raleway', fontSize: 14),
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
                            style:
                                TextStyle(fontFamily: 'Raleway', fontSize: 14),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            movie.overview!,
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 14,
                                color: Color(0xFFADADAD)),
                          ),
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
    );
  }
}
