import 'package:json_annotation/json_annotation.dart';

part 'modele_API.g.dart';

@JsonSerializable()
class SeriesResponse {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'count_of_episodes')
  final int countOfEpisodes;

  @JsonKey(name: 'start_year')
  final String startYear;

  @JsonKey(name: 'publisher')
  final Publisher? publisher;

  @JsonKey(name: 'image')
  final ImageApi? image;

  @JsonKey(name: 'description')
  final String? description;



  SeriesResponse(this.name, this.publisher , this.countOfEpisodes, this.startYear, this.image, this.description);

  factory SeriesResponse.fromJson(Map<String, dynamic> json) {
    final publisherJson = json['publisher'];
    final imageJson = json['image'];

    // Vérification si null
    final Publisher? publisher = publisherJson != null ? Publisher.fromJson(publisherJson) : null;
    final ImageApi? image = imageJson != null ? ImageApi.fromJson(imageJson) : null;

    return SeriesResponse(
      json['name'] as String,
      publisher,
      json['count_of_episodes'] as int,
      json['start_year'] as String,
      image,
      json['description'] as String?,

    );
  }

  Map<String, dynamic> toJson() => _$SeriesResponseToJson(this);
}
@JsonSerializable()
class MoviesResponse {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'runtime')
  final String? runtime;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'image')
  final ImageApi? image;

  MoviesResponse(this.name, this.releaseDate , this.runtime, this.description, this.image);

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    final imageJson = json['image'];
    final ImageApi? image = imageJson != null ? ImageApi.fromJson(imageJson) : null;


    return MoviesResponse(
      json['name'] as String?,
      json['release_date'] as String?,
      json['runtime'] as String?,
      json['description'] as String?,
      image,

    );
  }

  Map<String, dynamic> toJson() => _$MoviesResponseToJson(this);
}




@JsonSerializable()
class ComicsResponse {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'issue_number')
  final String? issuesNumber;

  @JsonKey(name: 'volume')
  final Volume? volume;

  @JsonKey(name: 'cover_date')
  final String? coverDate;

  @JsonKey(name: 'image')
  final ImageApi? image;

  ComicsResponse(this.name, this.issuesNumber , this.volume, this.coverDate, this.image);

  factory ComicsResponse.fromJson(Map<String, dynamic> json) {
    final imageJson = json['image'];
    final ImageApi? image = imageJson != null ? ImageApi.fromJson(imageJson) : null;
    final volumeJson = json['volume'];
    final Volume? volume = volumeJson != null ? Volume.fromJson(volumeJson) : null;


    return ComicsResponse(
      json['name'] as String?,
      json['issue_number'] as String?,
      volume,
      json['cover_date'] as String?,
      image,
    );
  }

  Map<String, dynamic> toJson() => _$ComicsResponseToJson(this);
}

@JsonSerializable()
class CharactersResponse {

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'real_name')
  final String? realName;

  @JsonKey(name: 'aliases')
  final String? alias;

  @JsonKey(name: 'deck')
  final String? deck;

  @JsonKey(name: 'gender')
  final int? gender;

  @JsonKey(name: 'birth')
  final String? birth;

  @JsonKey(name: 'image')
  final ImageApi? image;

  CharactersResponse(this.name, this.realName , this.alias, this.deck, this.gender, this.birth , this.image);

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    final imageJson = json['image'];
    final ImageApi? image = imageJson != null ? ImageApi.fromJson(imageJson) : null;


    return CharactersResponse(
      json['name'] as String?,
      json['real_name'] as String?,
      json['alias'] as String?,
      json['deck'] as String?,
      json['gender'] as int?,
      json['birth'] as String?,
      image,
    );
  }

  Map<String, dynamic> toJson() => _$CharactersResponseToJson(this);
}

@JsonSerializable()
class EpisodesResponse {

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'episode_number')
  final String? episodeNumber;

  @JsonKey(name: 'air_date')
  final String? date;

  @JsonKey(name: 'image')
  final ImageApi? image;

  EpisodesResponse(this.name, this.episodeNumber , this.date , this.image);

  factory EpisodesResponse.fromJson(Map<String, dynamic> json) {
    final imageJson = json['image'];
    final ImageApi? image = imageJson != null ? ImageApi.fromJson(imageJson) : null;


    return EpisodesResponse(
      json['name'] as String?,
      json['episode_number'] as String?,
      json['air_date'] as String?,
      image,
    );
  }

  Map<String, dynamic> toJson() => _$EpisodesResponseToJson(this);
}

/* sous-classes */



@JsonSerializable()
class Publisher {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'api_detail_url')
  final String apiDetailUrl;

  Publisher(this.apiDetailUrl, this.id, this.name);

  factory Publisher.fromJson(Map<String, dynamic> json) =>
      _$PublisherFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherToJson(this);
}


@JsonSerializable()
class ImageApi {

  @JsonKey(name: 'small_url')
  final String screenUrl;

  ImageApi(this.screenUrl);

  factory ImageApi.fromJson(Map<String, dynamic> json) =>
      _$ImageApiFromJson(json);

  Map<String, dynamic> toJson() => _$ImageApiToJson(this);
}

@JsonSerializable()
class Volume {

  @JsonKey(name: 'name')
  final String name;

  Volume(this.name);

  factory Volume.fromJson(Map<String, dynamic> json) =>
      _$VolumeFromJson(json);

  Map<String, dynamic> toJson() => _$VolumeToJson(this);
}

