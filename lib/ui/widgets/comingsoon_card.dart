import 'package:flutix/model/movie_playing.dart';
import 'package:flutter/material.dart';

class ComingsoonCard extends StatelessWidget {
  final MoviePlaying movie;
  const ComingsoonCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        SizedBox(
          width: 100,
          height: 140,
          child: Image.asset(movie.link),
        ),
      ],
    ));
  }
}