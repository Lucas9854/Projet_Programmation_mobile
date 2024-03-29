// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modele_API.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesResponse _$SeriesResponseFromJson(Map<String, dynamic> json) =>
    SeriesResponse(
      json['name'] as String,
      json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      json['count_of_episodes'] as int,
      json['start_year'] as String,
      json['image'] == null
          ? null
          : ImageApi.fromJson(json['image'] as Map<String, dynamic>),
      json['description'] as String?,
    );

Map<String, dynamic> _$SeriesResponseToJson(SeriesResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count_of_episodes': instance.countOfEpisodes,
      'start_year': instance.startYear,
      'publisher': instance.publisher,
      'image': instance.image,
      'description': instance.description,
    };

MoviesResponse _$MoviesResponseFromJson(Map<String, dynamic> json) =>
    MoviesResponse(
      json['name'] as String,
      json['release_date'] as String,
      json['runtime'] as int,
      json['image'] == null
          ? null
          : ImageApi.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MoviesResponseToJson(MoviesResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'release_date': instance.releaseDate,
      'runtime': instance.runtime,
      'image': instance.image,
    };

ComicsResponse _$ComicsResponseFromJson(Map<String, dynamic> json) =>
    ComicsResponse(
      json['name'] as String,
      json['issue_number'] as String,
      json['volume'] == null
          ? null
          : Volume.fromJson(json['volume'] as Map<String, dynamic>),
      json['cover_date'] as String,
      json['image'] == null
          ? null
          : ImageApi.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicsResponseToJson(ComicsResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'issue_number': instance.issuesNumber,
      'volume': instance.volume,
      'cover_date': instance.coverDate,
      'image': instance.image,
    };

CharactersResponse _$CharactersResponseFromJson(Map<String, dynamic> json) =>
    CharactersResponse(
      json['name'] as String,
      json['real_name'] as String,
      json['aliases'] as String,
      json['deck'] as String,
      json['gender'] as int,
      json['birth'] as String?,
      json['image'] == null
          ? null
          : ImageApi.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharactersResponseToJson(CharactersResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'real_name': instance.realName,
      'aliases': instance.alias,
      'deck': instance.deck,
      'gender': instance.gender,
      'birth': instance.birth,
      'image': instance.image,
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

ImageApi _$ImageApiFromJson(Map<String, dynamic> json) => ImageApi(
      json['screen_url'] as String,
    );

Map<String, dynamic> _$ImageApiToJson(ImageApi instance) => <String, dynamic>{
      'screen_url': instance.screenUrl,
    };

Volume _$VolumeFromJson(Map<String, dynamic> json) => Volume(
      json['name'] as String,
    );

Map<String, dynamic> _$VolumeToJson(Volume instance) => <String, dynamic>{
      'name': instance.name,
    };
