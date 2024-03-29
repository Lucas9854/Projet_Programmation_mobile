// comics_api.dart

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:application_comics/modele_API.dart';

part 'comics_api.g.dart';

@RestApi(baseUrl: 'https://api.formation-android.fr/comicvine')
abstract class ComicsAPI {
  factory ComicsAPI(Dio dio, {required String baseUrl}) = _ComicsAPI;

  @GET('')
  Future<List<ComicsResponse>> loadComicsList(
      @Query('url') String url,
      @Query('api_key') String apiKey,
      @Query('format') String format,
      );

  @GET('')
  Future<List<SeriesResponse>> loadSeriesList(
      @Query('url') String url,
      @Query('api_key') String apiKey,
      @Query('format') String format,
      );

  @GET('')
  Future<List<MoviesResponse>> loadMoviesList(
      @Query('url') String url,
      @Query('api_key') String apiKey,
      @Query('format') String format,
      );

  @GET('')
  Future<List<CharactersResponse>> loadCharactersList(
      @Query('url') String url,
      @Query('api_key') String apiKey,
      @Query('format') String format,
      );
}

class ComicsRequest {
  static final ComicsRequest _singleton = ComicsRequest._internal();

  factory ComicsRequest() {
    return _singleton;
  }

  ComicsRequest._internal();

  final Dio _dio = Dio();

  Future<List<ComicsResponse>> loadComicsList(String endpoint) async {
    try {
      final String apiKey = '07165e05c9d2ef5705474d1061cfd1df53b2719e';
      final String apiUrl = 'https://api.formation-android.fr/comicvine';

      final response = await _dio.get(
        '$apiUrl?url=$endpoint&api_key=$apiKey&format=json',
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data['results'];

        if (jsonResponse is List) {
          return jsonResponse
              .map((json) => ComicsResponse.fromJson(json))
              .toList();
        } else {
          throw Exception('Expected a list of comics from API');
        }
      } else {
        throw Exception('Failed to load comics list');
      }
    } catch (e) {
      throw Exception('Failed to load comics list: $e');
    }
  }

  Future<List<SeriesResponse>> loadSeriesList(String endpoint) async {
    // Implémentez de manière similaire pour charger la liste des séries
    try {
      final String apiKey = '07165e05c9d2ef5705474d1061cfd1df53b2719e';
      final String apiUrl = 'https://api.formation-android.fr/comicvine';

      final response = await _dio.get(
        '$apiUrl?url=$endpoint&api_key=$apiKey&format=json',
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data['results'];

        if (jsonResponse is List) {
          return jsonResponse
              .map((json) => SeriesResponse.fromJson(json))
              .toList();
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

  Future<List<MoviesResponse>> loadMoviesList(String endpoint) async {
    // Implémentez de manière similaire pour charger la liste des films
    try {
      final String apiKey = '07165e05c9d2ef5705474d1061cfd1df53b2719e';
      final String apiUrl = 'https://api.formation-android.fr/comicvine';

      final response = await _dio.get(
        '$apiUrl?url=$endpoint&api_key=$apiKey&format=json',
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data['results'];

        if (jsonResponse is List) {
          return jsonResponse
              .map((json) => MoviesResponse.fromJson(json))
              .toList();
        } else {
          throw Exception('Expected a list of movies from API');
        }
      } else {
        throw Exception('Failed to load movies list');
      }
    } catch (e) {
      throw Exception('Failed to load movies list: $e');
    }
  }

  Future<List<CharactersResponse>> loadCharactersList(String endpoint) async {
    // Implémentez de manière similaire pour charger la liste des personnages
    try {
      final String apiKey = '07165e05c9d2ef5705474d1061cfd1df53b2719e';
      final String apiUrl = 'https://api.formation-android.fr/comicvine';

      final response = await _dio.get(
        '$apiUrl?url=$endpoint&api_key=$apiKey&format=json',
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data['results'];

        if (jsonResponse is List) {
          return jsonResponse
              .map((json) => CharactersResponse.fromJson(json))
              .toList();
        } else {
          throw Exception('Expected a list of characters from API');
        }
      } else {
        throw Exception('Failed to load characters list');
      }
    } catch (e) {
      throw Exception('Failed to load characters list: $e');
    }
  }

  String getApiUrl(String path) {
    return 'https://api.formation-android.fr/comicvine/$path';
  }
}
