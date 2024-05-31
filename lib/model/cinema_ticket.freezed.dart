// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cinema_ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CinemaTicket _$CinemaTicketFromJson(Map<String, dynamic> json) {
  return _CinemaTicket.fromJson(json);
}

/// @nodoc
mixin _$CinemaTicket {
  String? get idOrder => throw _privateConstructorUsedError;
  MoviePlaying? get movie => throw _privateConstructorUsedError;
  String? get cinema => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get time => throw _privateConstructorUsedError;
  String? get seatNumber => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  String? get fee => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CinemaTicketCopyWith<CinemaTicket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CinemaTicketCopyWith<$Res> {
  factory $CinemaTicketCopyWith(
          CinemaTicket value, $Res Function(CinemaTicket) then) =
      _$CinemaTicketCopyWithImpl<$Res, CinemaTicket>;
  @useResult
  $Res call(
      {String? idOrder,
      MoviePlaying? movie,
      String? cinema,
      String? date,
      String? time,
      String? seatNumber,
      String? price,
      String? fee,
      int? total});

  $MoviePlayingCopyWith<$Res>? get movie;
}

/// @nodoc
class _$CinemaTicketCopyWithImpl<$Res, $Val extends CinemaTicket>
    implements $CinemaTicketCopyWith<$Res> {
  _$CinemaTicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idOrder = freezed,
    Object? movie = freezed,
    Object? cinema = freezed,
    Object? date = freezed,
    Object? time = freezed,
    Object? seatNumber = freezed,
    Object? price = freezed,
    Object? fee = freezed,
    Object? total = freezed,
  }) {
    return _then(_value.copyWith(
      idOrder: freezed == idOrder
          ? _value.idOrder
          : idOrder // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as MoviePlaying?,
      cinema: freezed == cinema
          ? _value.cinema
          : cinema // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      seatNumber: freezed == seatNumber
          ? _value.seatNumber
          : seatNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as String?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MoviePlayingCopyWith<$Res>? get movie {
    if (_value.movie == null) {
      return null;
    }

    return $MoviePlayingCopyWith<$Res>(_value.movie!, (value) {
      return _then(_value.copyWith(movie: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CinemaTicketImplCopyWith<$Res>
    implements $CinemaTicketCopyWith<$Res> {
  factory _$$CinemaTicketImplCopyWith(
          _$CinemaTicketImpl value, $Res Function(_$CinemaTicketImpl) then) =
      __$$CinemaTicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? idOrder,
      MoviePlaying? movie,
      String? cinema,
      String? date,
      String? time,
      String? seatNumber,
      String? price,
      String? fee,
      int? total});

  @override
  $MoviePlayingCopyWith<$Res>? get movie;
}

/// @nodoc
class __$$CinemaTicketImplCopyWithImpl<$Res>
    extends _$CinemaTicketCopyWithImpl<$Res, _$CinemaTicketImpl>
    implements _$$CinemaTicketImplCopyWith<$Res> {
  __$$CinemaTicketImplCopyWithImpl(
      _$CinemaTicketImpl _value, $Res Function(_$CinemaTicketImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idOrder = freezed,
    Object? movie = freezed,
    Object? cinema = freezed,
    Object? date = freezed,
    Object? time = freezed,
    Object? seatNumber = freezed,
    Object? price = freezed,
    Object? fee = freezed,
    Object? total = freezed,
  }) {
    return _then(_$CinemaTicketImpl(
      idOrder: freezed == idOrder
          ? _value.idOrder
          : idOrder // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as MoviePlaying?,
      cinema: freezed == cinema
          ? _value.cinema
          : cinema // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      seatNumber: freezed == seatNumber
          ? _value.seatNumber
          : seatNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as String?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CinemaTicketImpl implements _CinemaTicket {
  const _$CinemaTicketImpl(
      {this.idOrder,
      this.movie,
      this.cinema,
      this.date,
      this.time,
      this.seatNumber,
      this.price,
      this.fee,
      this.total});

  factory _$CinemaTicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$CinemaTicketImplFromJson(json);

  @override
  final String? idOrder;
  @override
  final MoviePlaying? movie;
  @override
  final String? cinema;
  @override
  final String? date;
  @override
  final String? time;
  @override
  final String? seatNumber;
  @override
  final String? price;
  @override
  final String? fee;
  @override
  final int? total;

  @override
  String toString() {
    return 'CinemaTicket(idOrder: $idOrder, movie: $movie, cinema: $cinema, date: $date, time: $time, seatNumber: $seatNumber, price: $price, fee: $fee, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CinemaTicketImpl &&
            (identical(other.idOrder, idOrder) || other.idOrder == idOrder) &&
            (identical(other.movie, movie) || other.movie == movie) &&
            (identical(other.cinema, cinema) || other.cinema == cinema) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.seatNumber, seatNumber) ||
                other.seatNumber == seatNumber) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idOrder, movie, cinema, date,
      time, seatNumber, price, fee, total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CinemaTicketImplCopyWith<_$CinemaTicketImpl> get copyWith =>
      __$$CinemaTicketImplCopyWithImpl<_$CinemaTicketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CinemaTicketImplToJson(
      this,
    );
  }
}

abstract class _CinemaTicket implements CinemaTicket {
  const factory _CinemaTicket(
      {final String? idOrder,
      final MoviePlaying? movie,
      final String? cinema,
      final String? date,
      final String? time,
      final String? seatNumber,
      final String? price,
      final String? fee,
      final int? total}) = _$CinemaTicketImpl;

  factory _CinemaTicket.fromJson(Map<String, dynamic> json) =
      _$CinemaTicketImpl.fromJson;

  @override
  String? get idOrder;
  @override
  MoviePlaying? get movie;
  @override
  String? get cinema;
  @override
  String? get date;
  @override
  String? get time;
  @override
  String? get seatNumber;
  @override
  String? get price;
  @override
  String? get fee;
  @override
  int? get total;
  @override
  @JsonKey(ignore: true)
  _$$CinemaTicketImplCopyWith<_$CinemaTicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
