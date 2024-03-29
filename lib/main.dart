import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:application_comics/comics_api.dart';
import 'package:application_comics/modele_API.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Series();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'accueil',
          builder: (BuildContext context, GoRouterState state) {
            return const Accueil();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Comics app',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        fontFamily: 'Nunito',
      ),
      routerConfig: _router,
    );
  }
}

class SeriesInfo {
  final String name;
  final String publisherName;
  final int countOfEpisodes;
  final String startYear;
  final String imageUrl;
  final String description;

  SeriesInfo({
    required this.name,
    required this.publisherName,
    required this.countOfEpisodes,
    required this.startYear,
    required this.imageUrl,
    required this.description,
  });
}
class MoviesInfo {
  final String name;
  final String releaseDate;
  final int runtime;
  final String imageUrl;

  MoviesInfo({
    required this.name,
    required this.releaseDate,
    required this.runtime,
    required this.imageUrl,
  });
}
class ComicsInfo {
  final String name;
  final String issuesNumber;
  final Volume? volume;
  final String coverDate;
  final String imageUrl;

  ComicsInfo({
    required this.name,
    required this.issuesNumber,
    required this.volume,
    required this.coverDate,
    required this.imageUrl,
  });
}
class CharactersInfo {
  final String name;
  final String realName;
  final String alias;
  final String deck;
  final int gender;
  final String? birth;
  final String imageUrl;

  CharactersInfo({
    required this.name,
    required this.realName,
    required this.alias,
    required this.deck,
    required this.gender,
    required this.birth,
    required this.imageUrl,
  });
}


class SeriesBloc {
  final _seriesController = StreamController<List<SeriesInfo>>();
  Stream<List<SeriesInfo>> get seriesStream => _seriesController.stream;

  SeriesBloc() {
    loadSeries();
  }

  void loadSeries() async {
    try {
      print('Chargement des séries en cours...');
      final List<SeriesResponse> seriesListResponse =
      await ComicsRequest().loadSeriesList('series_list');
      if (seriesListResponse.isNotEmpty) {
        final List<SeriesInfo> seriesInfoList = seriesListResponse.map((series) =>
            SeriesInfo(
              name: series.name,
              publisherName: series.publisher?.name ?? '',
              countOfEpisodes: series.countOfEpisodes,
              startYear: series.startYear,
              imageUrl: series.image?.screenUrl ?? '',
              description: series.description ?? '',
            )).toList();

        _seriesController.add(seriesInfoList);
      } else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des séries : $e');
      _seriesController.addError('Erreur lors du chargement des séries');
    }
  }

  void dispose() {
    _seriesController.close();
  }
}
class MoviesBloc {
  final _moviesController = StreamController<List<MoviesInfo>>();
  Stream<List<MoviesInfo>> get moviesStream => _moviesController.stream;

  MoviesBloc() {
    loadMovies();
  }

  void loadMovies() async {
    try {
      print('Chargement des films en cours...');
      final List<MoviesResponse> moviesListResponse =
      await ComicsRequest().loadMoviesList('movies');
      if (moviesListResponse.isNotEmpty) {
        final List<MoviesInfo> moviesInfoList = moviesListResponse.map((movies) =>
            MoviesInfo(
              name: movies.name,
              releaseDate: movies.releaseDate,
              runtime: movies.runtime,
              imageUrl: movies.image?.screenUrl ?? '',
            )).toList();

        _moviesController.add(moviesInfoList);
      } else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des séries : $e');
      _moviesController.addError('Erreur lors du chargement des séries');
    }
  }

  void dispose() {
    _moviesController.close();
  }
}
class ComicsBloc {
  final _comicsController = StreamController<List<ComicsInfo>>();
  Stream<List<ComicsInfo>> get comicsStream => _comicsController.stream;

  ComicsBloc() {
    loadComics();
  }

  void loadComics() async {
    try {
      print('Chargement des comics en cours...');
      final List<ComicsResponse> comicsListResponse =
      await ComicsRequest().loadComicsList('comics');
      if (comicsListResponse.isNotEmpty) {
        final List<ComicsInfo> comicsInfoList = comicsListResponse.map((comics) =>
            ComicsInfo(
              name: comics.name,
              issuesNumber: comics.issuesNumber,
              volume: comics.volume,
              coverDate: comics.coverDate,
              imageUrl: comics.image?.screenUrl ?? '',
            )).toList();

        _comicsController.add(comicsInfoList);
      } else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des comics : $e');
      _comicsController.addError('Erreur lors du chargement des comics');
    }
  }

  void dispose() {
    _comicsController.close();
  }
}

class CharactersBloc {
  final _charactersController = StreamController<List<CharactersInfo>>();
  Stream<List<CharactersInfo>> get charactersStream => _charactersController.stream;

  CharactersBloc() {
    loadCharacters();
  }

  void loadCharacters() async {
    try {
      print('Chargement des personnages en cours...');
      final List<CharactersResponse> charactersListResponse =
      await ComicsRequest().loadCharactersList('characters');
      if (charactersListResponse.isNotEmpty) {
        final List<CharactersInfo> charactersInfoList = charactersListResponse.map((character) =>
            CharactersInfo(
              name: character.name,
              realName: character.realName,
              alias: character.alias,
              deck: character.deck,
              gender: character.gender,
              birth: character.birth,
              imageUrl: character.image?.screenUrl ?? '',
            )).toList();

        _charactersController.add(charactersInfoList);
      } else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des personnages : $e');
      _charactersController.addError('Erreur lors du chargement des personnages');
    }
  }

  void dispose() {
    _charactersController.close();
  }
}


class Series extends StatefulWidget {
  const Series({Key? key}) : super(key: key);

  @override
  _SeriesState createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  late final SeriesBloc _seriesBloc = SeriesBloc();

  @override
  void dispose() {
    _seriesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Séries les plus populaires'),
      ),
      body: StreamBuilder<List<SeriesInfo>>(
        stream: _seriesBloc.seriesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<SeriesInfo> seriesInfoList = snapshot.data!;
            return ListView.builder(
              itemCount: seriesInfoList.length,
              itemBuilder: (context, index) {
                final SeriesInfo seriesInfo = seriesInfoList[index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(seriesInfo.name),
                      Text('Publisher: ${seriesInfo.publisherName}'),
                      Text('Episodes: ${seriesInfo.countOfEpisodes}'),
                      Text('Start Year: ${seriesInfo.startYear}'),
                      Text('Description: ${seriesInfo.description}'),
                    ],
                  ),
                  leading: Image.network(
                    seriesInfo.imageUrl,
                    width: 80,
                    height: 80,
                  ),
                );
              },
            );
          } else {
            return const SizedBox(); // Placeholder
          }
        },
      ),
    );
  }
}

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Ecran 2 !')],
        ),
      ),
    );
  }
}
