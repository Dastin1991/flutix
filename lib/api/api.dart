import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutix/api/constants.dart';
import 'package:flutix/model/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  final playingApiUrl = "/movie/now_playing?api_key=$apiKey";
  final upComingApiUrl = "/movie/upcoming?api_key=$apiKey";

  final dio = Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3'));

  Future<DataMovie> getNowPlayingMovie() async {
    final response = await dio.get(playingApiUrl);
    return DataMovie.fromJson(response.data);
  }

  Future<DataMovie> getComingsoonMovie() async {
    final response = await dio.get(upComingApiUrl);
    return DataMovie.fromJson(response.data);
  }

  // Future<List<Movie>> getNowPlayingMovies() async {
  //   final response = await Dio().get(playingApiUrl);

  //   if (response.statusCode == 200) {
  //     var jsonList = response.data;

  //     print(jsonList);
  //   } else {
  //     throw Exception('Failed to load now playing');
  //   }
  // }

  // Future<List<Movie>> getComingSoonMovies() async {
  //   final response = await http.get(Uri.parse(upComingApiUrl));

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body)['results'];

  //     List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();

  //     return movies;
  //   } else {
  //     throw Exception('Failed to load now playing');
  //   }
  // }
}
