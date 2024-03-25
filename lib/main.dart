import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:application_comics/series_api.dart';
import 'package:application_comics/series_response.dart';
import 'package:application_comics/series_list_response.dart';

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
  final _seriesController = StreamController<List<SeriesListResponse>>();
  Stream<List<SeriesListResponse>> get seriesStream => _seriesController.stream;

  SeriesBloc() {
    loadSeries();
  }

  void loadSeries() async {
    try {
      final seriesListResponse = await SeriesRequest().loadSeriesList('series_list');
      _seriesController.add([seriesListResponse]); // Ajouter la réponse dans une liste
    } catch (e) {
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
      body: StreamBuilder<List<SeriesListResponse>>(
        stream: _seriesBloc.seriesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final seriesList = snapshot.data!;
            return ListView.builder(
              itemCount: seriesList.length,
              itemBuilder: (context, index) {
                final series = seriesList[index];
                return ListTile(
                  title: Text(series.name),
                  subtitle: Text('Nombre d\'épisodes: ${series.countOfEpisodes}'),
                  leading: Image.network(series.image),
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
