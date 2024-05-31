import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_playing.freezed.dart';
part 'movie_playing.g.dart';

@freezed
class MoviePlaying with _$MoviePlaying {
  const factory MoviePlaying({
    required int id,
    required String title,
    required double rating,
    required int star,
    required String link,
    String? overview,
  }) = _MoviePlaying;

  factory MoviePlaying.fromJson(Map<String, dynamic> json) =>
      _$MoviePlayingFromJson(json);
}
