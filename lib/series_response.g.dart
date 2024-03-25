// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesResponse _$SeriesResponseFromJson(Map<String, dynamic> json) =>
    SeriesResponse(
      json['count_of_episodes'] as int,
      json['id'] as int,
      json['description'] as String,
      json['publisher'] as String,
      json['name'] as String,
      json['start_year'] as int,
      json['character_credits'] as String,
    );

Map<String, dynamic> _$SeriesResponseToJson(SeriesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count_of_episodes': instance.countOfEpisodes,
      'description': instance.description,
      'publisher': instance.publisher,
      'name': instance.name,
      'start_year': instance.startYear,
      'character_credits': instance.characterCredits,
    };

SeriesResponseDescription _$SeriesResponseDescriptionFromJson(
        Map<String, dynamic> json) =>
    SeriesResponseDescription(
      json['name'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$SeriesResponseDescriptionToJson(
        SeriesResponseDescription instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
