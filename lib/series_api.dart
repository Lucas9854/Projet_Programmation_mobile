import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:application_comics/series_list_response.dart';

part 'series_api.g.dart';

@RestApi(baseUrl: 'https://api.formation-android.fr/comicvine')
abstract class SeriesAPI {
  factory SeriesAPI(Dio dio, {required String baseUrl}) = _SeriesAPI;

  @GET('')
  Future<SeriesListResponse> loadSeriesList(
      @Query('url') String url,
      @Query('api_key') String apiKey,
      @Query('format') String format,
      @Query('limit') int limit,
      );
}

class SeriesRequest {
  static final SeriesRequest _singleton = SeriesRequest._internal();

  factory SeriesRequest() {
    return _singleton;
  }

  SeriesRequest._internal();

  final SeriesAPI _api = SeriesAPI(
    Dio(BaseOptions()),
    baseUrl: 'https://api.formation-android.fr/comicvine',
  );

  Future<SeriesListResponse> loadSeriesList(String endpoint) {
    final apiKey = '07165e05c9d2ef5705474d1061cfd1df53b2719e';
    final format = 'json';
    final url = endpoint;
    final limit = 50;
    return _api.loadSeriesList(url, apiKey, format, limit);
  }
}
