import 'package:json_annotation/json_annotation.dart';

part 'modele_API.g.dart';

@JsonSerializable()
class SeriesListResponse {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'count_of_episodes')
  final int countOfEpisodes;

  @JsonKey(name: 'start_year')
  final String startYear;

  @JsonKey(name: 'publisher')
  final Publisher? publisher;

  @JsonKey(name: 'image')
  final ImageSeries? image;

  @JsonKey(name: 'description')
  final String? description;



  SeriesListResponse(this.name, this.publisher , this.countOfEpisodes, this.startYear, this.image, this.description);

  factory SeriesListResponse.fromJson(Map<String, dynamic> json) {
    final publisherJson = json['publisher'];
    final imageJson = json['image'];

    // Vérification si null
    final Publisher? publisher = publisherJson != null ? Publisher.fromJson(publisherJson) : null;
    final ImageSeries? image = imageJson != null ? ImageSeries.fromJson(imageJson) : null;

    return SeriesListResponse(
      json['name'] as String,
      publisher,
      json['count_of_episodes'] as int,
      json['start_year'] as String,
      image,
      json['description'] as String?,

    );
  }

  Map<String, dynamic> toJson() => _$SeriesListResponseToJson(this);
}

/*@JsonSerializable()
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
  final ImageSeries? image;

  SeriesListResponse(this.name, this.publisher , this.countOfEpisodes, this.startYear, this.image);

  factory SeriesResponse.fromJson(Map<String, dynamic> json) {
    final publisherJson = json['publisher'];
    final imageJson = json['image'];

    // Vérification si publisherJson est null
    final Publisher? publisher = publisherJson != null ? Publisher.fromJson(publisherJson) : null;
    final ImageSeries? image = imageJson != null ? ImageSeries.fromJson(imageJson) : null;


    return SeriesResponse(
      json['name'] as String,
      publisher,
      json['count_of_episodes'] as int,
      json['start_year'] as String,
      image,

    );
  }

  Map<String, dynamic> toJson() => _$SeriesListResponseToJson(this);
}*/


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
class ImageSeries {

  @JsonKey(name: 'screen_url')
  final String screenUrl;

  ImageSeries(this.screenUrl);

  factory ImageSeries.fromJson(Map<String, dynamic> json) =>
      _$ImageSeriesFromJson(json);

  Map<String, dynamic> toJson() => _$ImageSeriesToJson(this);
}
