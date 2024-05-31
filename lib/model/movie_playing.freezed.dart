// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_playing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MoviePlaying _$MoviePlayingFromJson(Map<String, dynamic> json) {
  return _MoviePlaying.fromJson(json);
}

/// @nodoc
mixin _$MoviePlaying {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get star => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoviePlayingCopyWith<MoviePlaying> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoviePlayingCopyWith<$Res> {
  factory $MoviePlayingCopyWith(
          MoviePlaying value, $Res Function(MoviePlaying) then) =
      _$MoviePlayingCopyWithImpl<$Res, MoviePlaying>;
  @useResult
  $Res call(
      {int id,
      String title,
      double rating,
      int star,
      String link,
      String? overview});
}

/// @nodoc
class _$MoviePlayingCopyWithImpl<$Res, $Val extends MoviePlaying>
    implements $MoviePlayingCopyWith<$Res> {
  _$MoviePlayingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? rating = null,
    Object? star = null,
    Object? link = null,
    Object? overview = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoviePlayingImplCopyWith<$Res>
    implements $MoviePlayingCopyWith<$Res> {
  factory _$$MoviePlayingImplCopyWith(
          _$MoviePlayingImpl value, $Res Function(_$MoviePlayingImpl) then) =
      __$$MoviePlayingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      double rating,
      int star,
      String link,
      String? overview});
}

/// @nodoc
class __$$MoviePlayingImplCopyWithImpl<$Res>
    extends _$MoviePlayingCopyWithImpl<$Res, _$MoviePlayingImpl>
    implements _$$MoviePlayingImplCopyWith<$Res> {
  __$$MoviePlayingImplCopyWithImpl(
      _$MoviePlayingImpl _value, $Res Function(_$MoviePlayingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? rating = null,
    Object? star = null,
    Object? link = null,
    Object? overview = freezed,
  }) {
    return _then(_$MoviePlayingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoviePlayingImpl implements _MoviePlaying {
  const _$MoviePlayingImpl(
      {required this.id,
      required this.title,
      required this.rating,
      required this.star,
      required this.link,
      this.overview});

  factory _$MoviePlayingImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoviePlayingImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final double rating;
  @override
  final int star;
  @override
  final String link;
  @override
  final String? overview;

  @override
  String toString() {
    return 'MoviePlaying(id: $id, title: $title, rating: $rating, star: $star, link: $link, overview: $overview)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoviePlayingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.star, star) || other.star == star) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.overview, overview) ||
                other.overview == overview));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, rating, star, link, overview);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoviePlayingImplCopyWith<_$MoviePlayingImpl> get copyWith =>
      __$$MoviePlayingImplCopyWithImpl<_$MoviePlayingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoviePlayingImplToJson(
      this,
    );
  }
}

abstract class _MoviePlaying implements MoviePlaying {
  const factory _MoviePlaying(
      {required final int id,
      required final String title,
      required final double rating,
      required final int star,
      required final String link,
      final String? overview}) = _$MoviePlayingImpl;

  factory _MoviePlaying.fromJson(Map<String, dynamic> json) =
      _$MoviePlayingImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  double get rating;
  @override
  int get star;
  @override
  String get link;
  @override
  String? get overview;
  @override
  @JsonKey(ignore: true)
  _$$MoviePlayingImplCopyWith<_$MoviePlayingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
