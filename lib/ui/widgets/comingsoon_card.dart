import 'package:flutix/model/movie_playing.dart';
import 'package:flutter/material.dart';

class ComingsoonCard extends StatelessWidget {
  final MoviePlaying movie;
  final Function onTap;
  const ComingsoonCard({Key? key, required this.movie, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: (Column(
        children: [
          SizedBox(
            width: 100,
            height: 140,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(movie.link)),
          ),
        ],
      )),
    );
  }
}
