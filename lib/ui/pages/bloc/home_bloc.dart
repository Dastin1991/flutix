import 'package:flutix/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutix/model/movie_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Api api;
  HomeBloc({required this.api}) : super(HomeInitial()) {
    on<LoadHome>((event, emit) async {
      emit(HomeLoading());

      try {
        final result = await api.getNowPlayingMovie();
        final upcoming = await api.getComingsoonMovie();
        emit(HomeLoaded(result.movie, upcoming.movie));
      } catch (error) {
        emit(HomeError(error.toString()));
      }
    });
  }
}
