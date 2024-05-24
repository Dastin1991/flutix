import 'package:flutix/model/user.dart';
import 'package:flutix/ui/widgets/genre_tile.dart';
import 'package:flutix/ui/widgets/button_icon.dart';
import 'package:flutix/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Genre extends StatefulWidget {
  UserProfile? users;
  Genre({super.key, this.users});

  @override
  State<Genre> createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  List<String> myGenre = <String>[
    'Horor',
    'Music',
    'Action',
    'Drama',
    'War',
    'Crime'
  ];

  List<String> myMovie = <String>[
    'Bahasa',
    'English',
    'Japanese',
    'Korean',
  ];

  List<String> selectedGenre = <String>[];
  List<String> selectedMovie = <String>[];

  Future confirmAccount() async {
    List<String> selectedGenres =
        selectedGenre.map((index) => myGenre[int.parse(index)]).toList();
    List<String> selectedMovies =
        selectedMovie.map((index) => myMovie[int.parse(index)]).toList();
    UserProfile user = UserProfile(
        fullname: widget.users!.fullname,
        email: widget.users!.email,
        pathImage: widget.users!.pathImage ?? widget.users!.pathImage,
        password: widget.users!.password,
        genre: selectedGenres.join(','),
        language: selectedMovies.join(','));

    context.goNamed('confirm', extra: user);
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;
    UserProfile? userProfile;
    if (arg is UserProfile) {
      userProfile = arg;
    }
    return SafeArea(
      child: (Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: ''),
              Container(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Your\nFavorite Genre',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      direction: Axis.horizontal,
                      children: List.generate(
                          myGenre.length,
                          (index) => GenreTile(
                              title: myGenre[index],
                              selected: selectedGenre.contains(index.toString())
                                  ? true
                                  : false,
                              onTap: () {
                                _onSelectedGenre(index);
                              })),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Movie Language\nYour Prefer?",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      direction: Axis.horizontal,
                      children: List.generate(
                        myMovie.length,
                        (index) => GenreTile(
                          title: myMovie[index],
                          selected: selectedMovie.contains(index.toString())
                              ? true
                              : false,
                          onTap: () {
                            _onSelectedMovie(index);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonIcon(
                enabled: selectedGenre.isNotEmpty && selectedMovie.isNotEmpty
                    ? true
                    : false,
                onTap: () {
                  confirmAccount();
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  void _onSelectedGenre(int index) {
    if (selectedGenre.contains(index.toString())) {
      setState(() {
        selectedGenre.remove(index.toString());
      });
    } else {
      setState(() {
        selectedGenre.add(index.toString());
      });
    }
  }

  void _onSelectedMovie(int index) {
    if (selectedMovie.contains(index.toString())) {
      setState(() {
        selectedMovie.remove(index.toString());
      });
    } else {
      setState(() {
        selectedMovie.add(index.toString());
      });
    }
  }

  _navigate() {}
}
