class MoviePlaying {
  String title;
  double rating;
  int star;
  String link;
  String? overview;

  MoviePlaying({
    required this.title,
    required this.rating,
    required this.star,
    required this.link,
    this.overview,
  });
}
