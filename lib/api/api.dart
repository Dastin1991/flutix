import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutix/api/constants.dart';
import 'package:flutix/model/movie_model.dart';
import 'package:flutix/model/movie_trailer.dart';
import 'package:flutix/model/transaction.dart';
import 'package:flutix/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Api {
  final playingApiUrl = "/movie/now_playing?api_key=$apiKey";
  final upComingApiUrl = "/movie/upcoming?api_key=$apiKey";
  // final videoApiUrl = "/movie/1011985/videos?api_key=$apiKey";

  final dio = Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3'));

  Future<DataMovie> getNowPlayingMovie() async {
    final response = await dio.get(playingApiUrl);
    return DataMovie.fromJson(response.data);
  }

  Future<List<MovieTrailer>> getVideoMovies(String id) async {
    final videoApiUrl = "/movie/$id/videos?api_key=$apiKey";
    print(videoApiUrl);
    final response = await dio.get(videoApiUrl);

    // Check if response.data is already decoded, otherwise decode it
    final dynamic responseData =
        response.data is String ? json.decode(response.data) : response.data;

    final List<dynamic> results = responseData['results'];

    final List<MovieTrailer> trailers = results
        .map((item) => MovieTrailer.fromJson(item as Map<String, dynamic>))
        .toList();

    return trailers;
  }

  Future<DataMovie> getComingsoonMovie() async {
    final response = await dio.get(upComingApiUrl);
    return DataMovie.fromJson(response.data);
  }

  Future<List<Transactions>> getFirestoreTransactions(String email) async {
    List<Transactions> transactions = [];
    try {
      DateTime? dateTime;
      String? formattedDate;

      DocumentSnapshot userSnapshot =
          await DatabaseServices.getUserByEmail(email!);

      if (userSnapshot.exists) {
        // User data found, you can access it using userSnapshot.data()
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        CollectionReference transactionCollection =
            userSnapshot.reference.collection('transactions');

        QuerySnapshot transactionsQuerySnapshot =
            await transactionCollection.get();

        transactions = transactionsQuerySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          if (data['type'] == 'topup') {
            dateTime = data['date'].toDate();
            formattedDate = DateFormat('E, dd MMMM yyyy').format(dateTime!);
          }

          // Format DateTime to your desired format
          return Transactions(
            id: data['id'], // Use document ID as the transaction ID
            title: data['title'],
            amount: data['amount'].toString(),
            description: data['description'],
            link: data['link'],
            type: data['type'],
            cinema: data['cinema'],
            date: data['type'] == 'topup' ? formattedDate : data['date'],
            seat: data['seat'],
            price: data['price'],
            fee: data['fee'],
            total: int.parse(data['total'].toString()),
          );
        }).toList();
        return transactions;
      }
      return transactions;
    } catch (error) {
      print('Error retrieving Firestore transactions: $error');
      throw error;
    }
  }
}
