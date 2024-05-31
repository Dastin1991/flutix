// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_playing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MoviePlayingImpl _$$MoviePlayingImplFromJson(Map<String, dynamic> json) =>
    _$MoviePlayingImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      rating: (json['rating'] as num).toDouble(),
      star: json['star'] as int,
      link: json['link'] as String,
      overview: json['overview'] as String?,
    );

Map<String, dynamic> _$$MoviePlayingImplToJson(_$MoviePlayingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'rating': instance.rating,
      'star': instance.star,
      'link': instance.link,
      'overview': instance.overview,
    };
