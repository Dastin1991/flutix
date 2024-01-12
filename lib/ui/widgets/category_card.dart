import 'package:flutix/model/movie_playing.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final MoviePlaying movie;
  const CategoryCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32.0),
      child: (Column(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(movie.link),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            movie.title,
            style: TextStyle(fontFamily: 'Raleway', fontSize: 12),
          )
        ],
      )),
    );
  }
}
