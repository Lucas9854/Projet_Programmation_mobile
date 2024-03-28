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

class SeriesBloc {
  final _seriesController = StreamController<List<SeriesInfo>>();
  Stream<List<SeriesInfo>> get seriesStream => _seriesController.stream;

  SeriesBloc() {
    loadSeries();
  }

  void loadSeries() async {
    try {
      print('Chargement des séries en cours...');
      final List<SeriesListResponse> seriesListResponse = await SeriesRequest().loadSeriesList('series_list');
      if (seriesListResponse.isNotEmpty) {
        //print('Données de la réponse de l\'API : $seriesListResponse');

        final List<SeriesInfo> seriesInfoList = seriesListResponse.map((series) =>
            SeriesInfo(
              name: series.name,
              publisherName: series.publisher?.name ?? '',
              countOfEpisodes: series.countOfEpisodes,
              startYear: series.startYear,
              imageUrl: series.image?.screenUrl ?? '',
              description: series.description??'',
            )
        ).toList();

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
