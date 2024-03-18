import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_trailer.freezed.dart';
part 'movie_trailer.g.dart';

@freezed
class MovieTrailer with _$MovieTrailer {
  const factory MovieTrailer(
      {required String name,
      required String key,
      required String site}) = _MovieTrailer;

  factory MovieTrailer.fromJson(Map<String, dynamic> json) =>
      _$MovieTrailerFromJson(json);
}
