class DataMovie {
  final List<Movie> movie;

  DataMovie({required this.movie});

  factory DataMovie.fromJson(Map<String, dynamic> json) => DataMovie(
      movie: List.from(json['results'].map((movie) => Movie.fromModel(movie))));
}

class Movie {
  final String title;
  final String backDropPath;
  final String overview;
  final String posterPath;

  Movie(
      {required this.title,
      required this.backDropPath,
      required this.overview,
      required this.posterPath});

  factory Movie.fromModel(Map<String, dynamic> json) {
    return Movie(
        title: json['title'],
        backDropPath: json['backdrop_path'],
        overview: json['overview'],
        posterPath: json['poster_path']);
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'title': title,
  //     'backDropPath': backDropPath,
  //     'overview': overview,
  //     'posterPath': posterPath
  //   };
  // }
}
