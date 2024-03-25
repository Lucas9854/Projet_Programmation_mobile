import 'package:json_annotation/json_annotation.dart';

part 'series_list_response.g.dart';

@JsonSerializable()
class SeriesListResponse {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'count_of_episodes')
  final int countOfEpisodes;
  @JsonKey(name: 'name')
  final String name;



  //@JsonKey(name: 'description')
  //final SeriesResponseDescription description;

  SeriesListResponse(
      this.countOfEpisodes,
      this.id,
      this.name,
      this.image,
      );

  factory SeriesListResponse.fromJson(Map<String, dynamic> json) =>
      _$SeriesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesListResponseToJson(this);
}

@JsonSerializable()
class SeriesListResponseDescription {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'url')
  final String url;

  SeriesListResponseDescription(this.name, this.url);

  factory SeriesListResponseDescription.fromJson(Map<String, dynamic> json) =>
      _$SeriesListResponseDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesListResponseDescriptionToJson(this);
}