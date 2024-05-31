import 'package:flutix/model/movie_playing.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cinema_ticket.freezed.dart';
part 'cinema_ticket.g.dart';

@freezed
class CinemaTicket with _$CinemaTicket {
  const factory CinemaTicket(
      {String? idOrder,
      MoviePlaying? movie,
      String? cinema,
      String? date,
      String? time,
      String? seatNumber,
      String? price,
      String? fee,
      int? total}) = _CinemaTicket;

  factory CinemaTicket.fromJson(Map<String, dynamic> json) =>
      _$CinemaTicketFromJson(json);
}
