// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_trailer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MovieTrailer _$MovieTrailerFromJson(Map<String, dynamic> json) {
  return _MovieTrailer.fromJson(json);
}

/// @nodoc
mixin _$MovieTrailer {
  String get name => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get site => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieTrailerCopyWith<MovieTrailer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieTrailerCopyWith<$Res> {
  factory $MovieTrailerCopyWith(
          MovieTrailer value, $Res Function(MovieTrailer) then) =
      _$MovieTrailerCopyWithImpl<$Res, MovieTrailer>;
  @useResult
  $Res call({String name, String key, String site});
}

/// @nodoc
class _$MovieTrailerCopyWithImpl<$Res, $Val extends MovieTrailer>
    implements $MovieTrailerCopyWith<$Res> {
  _$MovieTrailerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? key = null,
    Object? site = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      site: null == site
          ? _value.site
          : site // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieTrailerImplCopyWith<$Res>
    implements $MovieTrailerCopyWith<$Res> {
  factory _$$MovieTrailerImplCopyWith(
          _$MovieTrailerImpl value, $Res Function(_$MovieTrailerImpl) then) =
      __$$MovieTrailerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String key, String site});
}

/// @nodoc
class __$$MovieTrailerImplCopyWithImpl<$Res>
    extends _$MovieTrailerCopyWithImpl<$Res, _$MovieTrailerImpl>
    implements _$$MovieTrailerImplCopyWith<$Res> {
  __$$MovieTrailerImplCopyWithImpl(
      _$MovieTrailerImpl _value, $Res Function(_$MovieTrailerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? key = null,
    Object? site = null,
  }) {
    return _then(_$MovieTrailerImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      site: null == site
          ? _value.site
          : site // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieTrailerImpl implements _MovieTrailer {
  const _$MovieTrailerImpl(
      {required this.name, required this.key, required this.site});

  factory _$MovieTrailerImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieTrailerImplFromJson(json);

  @override
  final String name;
  @override
  final String key;
  @override
  final String site;

  @override
  String toString() {
    return 'MovieTrailer(name: $name, key: $key, site: $site)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieTrailerImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.site, site) || other.site == site));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, key, site);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieTrailerImplCopyWith<_$MovieTrailerImpl> get copyWith =>
      __$$MovieTrailerImplCopyWithImpl<_$MovieTrailerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieTrailerImplToJson(
      this,
    );
  }
}

abstract class _MovieTrailer implements MovieTrailer {
  const factory _MovieTrailer(
      {required final String name,
      required final String key,
      required final String site}) = _$MovieTrailerImpl;

  factory _MovieTrailer.fromJson(Map<String, dynamic> json) =
      _$MovieTrailerImpl.fromJson;

  @override
  String get name;
  @override
  String get key;
  @override
  String get site;
  @override
  @JsonKey(ignore: true)
  _$$MovieTrailerImplCopyWith<_$MovieTrailerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
