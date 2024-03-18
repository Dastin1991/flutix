import 'package:bloc/bloc.dart';
import 'package:flutix/api/api.dart';
import 'package:flutix/model/movie_model.dart';
import 'package:flutix/model/movie_trailer.dart';
import 'package:meta/meta.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final Api api;
  MovieDetailBloc({required this.api}) : super(MovieDetailInitial()) {
    on<LoadMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());

      try {
        print('bloc movie detail');
        final result = await api.getVideoMovies(event.id);
        emit(MovieDetailLoaded(result));
      } catch (error) {
        emit(MovieDetailError(error.toString()));
      }
    });
  }
}
