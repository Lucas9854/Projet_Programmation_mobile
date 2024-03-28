// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modele_API.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesListResponse _$SeriesListResponseFromJson(Map<String, dynamic> json) =>
    SeriesListResponse(
      json['name'] as String,
      json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      json['count_of_episodes'] as int,
      json['start_year'] as String,
      json['image'] == null
          ? null
          : ImageSeries.fromJson(json['image'] as Map<String, dynamic>),
      json['description'] as String?,
    );

Map<String, dynamic> _$SeriesListResponseToJson(SeriesListResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count_of_episodes': instance.countOfEpisodes,
      'start_year': instance.startYear,
      'publisher': instance.publisher,
      'image': instance.image,
      'description': instance.description,
    };

Publisher _$PublisherFromJson(Map<String, dynamic> json) => Publisher(
      json['api_detail_url'] as String,
      json['id'] as int,
      json['name'] as String,
    );

Map<String, dynamic> _$PublisherToJson(Publisher instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'api_detail_url': instance.apiDetailUrl,
    };

ImageSeries _$ImageSeriesFromJson(Map<String, dynamic> json) => ImageSeries(
      json['screen_url'] as String,
    );

Map<String, dynamic> _$ImageSeriesToJson(ImageSeries instance) =>
    <String, dynamic>{
      'screen_url': instance.screenUrl,
    };
