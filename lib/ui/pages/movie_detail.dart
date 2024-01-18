import 'package:flutix/model/movie_playing.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final MoviePlaying? movie;

  const MovieDetail({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;
    MoviePlaying? movie;

    if (arg is MoviePlaying) {
      movie = arg;
    }
    return SafeArea(
      child: (Scaffold(
        body: movie != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: 270,
                      child: Image(
                        image: AssetImage(movie.link),
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      movie.title,
                      style:
                          const TextStyle(fontFamily: 'Raleway', fontSize: 24),
                    ),
                  ),
                  const Center(
                    child: const Text(
                      "Action - English",
                      style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 12,
                          color: Color(0xFFADADAD)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Cast & Crew",
                          style: TextStyle(fontFamily: 'Raleway', fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Storyline",
                          style: TextStyle(fontFamily: 'Raleway', fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "The near future, a time when both hope and hard ships drive humanity to look to the stars and beyond while a mysterious.\n\nNick Fury is compelled to launch the Avengers Initiative when Loki poses a threat to planet Earth. His squad of superheroes put their minds together to accomplish the task.",
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
                                primary: const Color(0xff503E9D)),
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text("Continue to Book"))),
                  ),
                ],
              )
            : Container(),
      )),
    );
  }
}