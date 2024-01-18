import 'package:flutix/model/movie_playing.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final MoviePlaying movie;
  final Function onTap;

  const MovieCard({Key? key, required this.movie, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Stack(
        children: [
          SizedBox(
              width: 210,
              height: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  movie.link,
                  fit: BoxFit.fill,
                ),
              )),
          Column(
            children: [
              Container(
                height: 100,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(bottom: 0, left: 16),
                child: Text(
                  movie.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Raleway',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(bottom: 10, left: 16),
                child: Text(
                  movie.title,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'Raleway', fontSize: 14),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
