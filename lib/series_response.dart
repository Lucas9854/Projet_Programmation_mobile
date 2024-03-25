import 'package:json_annotation/json_annotation.dart';

part 'series_response.g.dart';

@JsonSerializable()
class SeriesResponse {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'count_of_episodes')
  final int countOfEpisodes;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'publisher')
  final String publisher;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'start_year')
  final int startYear;
  @JsonKey(name: 'character_credits')
  final String characterCredits;



  //@JsonKey(name: 'description')
  //final SeriesResponseDescription description;

  SeriesResponse(
      this.countOfEpisodes,
      this.id,
      this.description,
      this.publisher,
      this.name,
      this.startYear,
      this.characterCredits,
      );

  factory SeriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SeriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesResponseToJson(this);
}

@JsonSerializable()
class SeriesResponseDescription {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'url')
  final String url;

  SeriesResponseDescription(this.name, this.url);

  factory SeriesResponseDescription.fromJson(Map<String, dynamic> json) =>
      _$SeriesResponseDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesResponseDescriptionToJson(this);
}