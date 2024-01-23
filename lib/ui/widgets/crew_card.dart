import 'package:flutix/model/crew.dart';
import 'package:flutix/model/movie_playing.dart';
import 'package:flutter/material.dart';

class CrewCard extends StatelessWidget {
  final Crew crew;
  final Function onTap;

  const CrewCard({Key? key, required this.crew, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap(),
        child: SizedBox(
          width: 70,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 70,
                  height: 80,
                  child: Image(
                    image: AssetImage(crew.profile),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                crew.name,
                style: const TextStyle(fontFamily: 'Raleway', fontSize: 12),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
