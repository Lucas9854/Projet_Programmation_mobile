import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:application_comics/modele_API.dart';

part 'comics_api.g.dart';

@RestApi(baseUrl: 'https://api.formation-android.fr/comicvine')
abstract class SeriesAPI {
  factory SeriesAPI(Dio dio, {required String baseUrl}) = _SeriesAPI;

  @GET('')
  Future<List<SeriesListResponse>> loadSeriesList(
      @Query('url') String url,
      @Query('api_key') String apiKey,
      @Query('format') String format,
      //@Query('limit') int limit,
      );
}

class SeriesRequest {
  static final SeriesRequest _singleton = SeriesRequest._internal();

  factory SeriesRequest() {
    return _singleton;
  }

  SeriesRequest._internal();

  final Dio _dio = Dio();

  Future<List<SeriesListResponse>> loadSeriesList(String endpoint) async {
    try {
      final String apiKey = '07165e05c9d2ef5705474d1061cfd1df53b2719e';
      final String apiUrl = 'https://api.formation-android.fr/comicvine';

      final response = await _dio.get(
        '$apiUrl?url=$endpoint&api_key=$apiKey&format=json',
      );

      if (response.statusCode == 200) {
        // Accéder à la clé "results" du JSON
        final jsonResponse = response.data['results'];

        // Vérifier si la clé "results" est une liste valide
        if (jsonResponse is List) {
          // Convertir les données JSON en une liste d'objets SeriesListResponse
          final List<SeriesListResponse> seriesList = jsonResponse
              .map((json) => SeriesListResponse.fromJson(json))
              .toList();

          return seriesList;
        } else {
          throw Exception('Expected a list of series from API');
        }
      } else {
        throw Exception('Failed to load series list');
      }
    } catch (e) {
      throw Exception('Failed to load series list: $e');
    }
  }








  // Méthode pour obtenir l'URL complète de l'API
  String getApiUrl(String path) {
    return 'https://api.formation-android.fr/comicvine/$path';
  }
}
