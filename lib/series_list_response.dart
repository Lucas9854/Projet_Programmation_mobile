import 'package:json_annotation/json_annotation.dart';

part 'series_list_response.g.dart';

@JsonSerializable()
class SeriesListResponse {
  @JsonKey(name: 'name')
  final String name;

  SeriesListResponse(this.name);

  factory SeriesListResponse.fromJson(Map<String, dynamic> json) =>
      _$SeriesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesListResponseToJson(this);
}
