part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailState {}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final List<MovieTrailer> movieTrailers;

  MovieDetailLoaded(this.movieTrailers);
}

final class MovieDetailError extends MovieDetailState {
  final String error;
  MovieDetailError(this.error);
}
