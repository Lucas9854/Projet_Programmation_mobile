// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesListResponse _$SeriesListResponseFromJson(Map<String, dynamic> json) =>
    SeriesListResponse(
      json['count_of_episodes'] as int,
      json['id'] as int,
      json['name'] as String,
      json['image'] as String,
    );

Map<String, dynamic> _$SeriesListResponseToJson(SeriesListResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'count_of_episodes': instance.countOfEpisodes,
      'name': instance.name,
    };

SeriesListResponseDescription _$SeriesListResponseDescriptionFromJson(
        Map<String, dynamic> json) =>
    SeriesListResponseDescription(
      json['name'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$SeriesListResponseDescriptionToJson(
        SeriesListResponseDescription instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
