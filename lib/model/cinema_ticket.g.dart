// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CinemaTicketImpl _$$CinemaTicketImplFromJson(Map<String, dynamic> json) =>
    _$CinemaTicketImpl(
      idOrder: json['idOrder'] as String?,
      movie: json['movie'] == null
          ? null
          : MoviePlaying.fromJson(json['movie'] as Map<String, dynamic>),
      cinema: json['cinema'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      seatNumber: json['seatNumber'] as String?,
      price: json['price'] as String?,
      fee: json['fee'] as String?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$$CinemaTicketImplToJson(_$CinemaTicketImpl instance) =>
    <String, dynamic>{
      'idOrder': instance.idOrder,
      'movie': instance.movie,
      'cinema': instance.cinema,
      'date': instance.date,
      'time': instance.time,
      'seatNumber': instance.seatNumber,
      'price': instance.price,
      'fee': instance.fee,
      'total': instance.total,
    };
