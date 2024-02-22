part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<Movie> movies;
  final List<Movie> upcoming;
  HomeLoaded(this.movies, this.upcoming);
}

final class HomeError extends HomeState {
  final String error;
  HomeError(this.error);
}
