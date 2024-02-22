import 'package:flutix/model/movie_playing.dart';

class CinemaTicket {
  String? idOrder;
  MoviePlaying? movie;
  String? cinema;
  String? date;
  String? time;
  String? seatNumber;
  String? price;
  String? fee;
  String? total;

  CinemaTicket(
      {this.idOrder,
      this.movie,
      this.cinema,
      this.date,
      this.time,
      this.seatNumber,
      this.price,
      this.fee,
      this.total});
}
