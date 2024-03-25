import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:application_comics/series_api.dart';
import 'package:application_comics/series_response.dart';
import 'package:application_comics/series_list_response.dart';
import 'package:dio/dio.dart';

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
class SeriesBloc {
  final _seriesController = StreamController<List<String>>();
  Stream<List<String>> get seriesStream => _seriesController.stream;

  SeriesBloc() {
    loadSeries();
  }

  void loadSeries() async {
    try {
      print('Chargement des séries en cours...');
      final List<SeriesListResponse> seriesListResponse = await SeriesRequest().loadSeriesList('series_list');
      print('hello');
      if (seriesListResponse.isNotEmpty) {
        print('Données de la réponse de l\'API : $seriesListResponse');

        // Vous pouvez accéder à la liste et la traiter ici
        final List<String> seriesNames = seriesListResponse.map((series) => series.name).toList();
        // Utilisez seriesNames comme vous le souhaitez

        _seriesController.add(seriesNames); // Mettez à jour le Stream avec les noms des séries
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
      body: StreamBuilder<List<String>>(
        stream: _seriesBloc.seriesStream, // Utilisez le stream de titres de séries
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final seriesTitles = snapshot.data!;
            return ListView.builder(
              itemCount: seriesTitles.length,
              itemBuilder: (context, index) {
                final title = seriesTitles[index];
                return ListTile(
                  title: Text(title),
                  // Vous pouvez personnaliser l'affichage des séries comme vous le souhaitez
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
