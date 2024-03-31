import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'dart:math';
import 'DetailFilm.dart';
import 'package:application_comics/comics_api.dart';
import 'package:application_comics/modele_API.dart';
import 'Series.dart';
import 'main.dart';
import 'Comics.dart';
import 'Recherche.dart';

class MoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Films',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF15232E),
      ),
      home: MoviesListPage(),
    );
  }
}

class MoviesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Films les plus populaires',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF15232E),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('res/svg/navbar_home.svg', width: 24, height: 24, color : Color(0xFF778BA8)),
            label: 'Accueil',

          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('res/svg/navbar_series.svg', width: 24, height: 24,color : Color(0xFF778BA8)),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('res/svg/navbar_comics.svg', width: 24, height: 24,color : Color(0xFF778BA8)),
            label: 'Comics',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('res/svg/navbar_movies.svg', width: 24, height: 24,color : Color(0xFF778BA8)),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('res/svg/navbar_search.svg', width: 24, height: 24,color : Color(0xFF778BA8)),
            label: 'Recherche',
          ),
        ],
        backgroundColor: Color(0xFF0F1E2B),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {

          switch (index) {
            case 0: // Accueil
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()), // Naviguer vers la page d'accueil
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SeriesPage()),
              ); // Naviguer vers la page des séries
              break;
            case 2: // Comics
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ComicsPage()),
              );
              break;
            case 3: // Films
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MoviesPage()),
              );
              break;
            case 4: // Recherche
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
              break;
            default:
          }
        },
      ),
      body: MoviesListWidget(),
      // BottomNavigationBar reste inchangé
    );
  }
}

class MoviesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MovieInfo>>(
      stream: MoviesBloc().moviesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final List<MovieInfo> movieInfoList = snapshot.data!;
          return ListView.builder(
            itemCount: movieInfoList.length,
            itemBuilder: (context, index) {
              final MovieInfo movieInfo = movieInfoList[index];
              return MovieWidget(

                movieInfo: movieInfo,
              );
            },
          );
        } else {
          return SizedBox(); // Placeholder
        }
      },
    );
  }
}

class MovieWidget extends StatelessWidget {
  final MovieInfo movieInfo;

  MovieWidget({
    required this.movieInfo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigation vers la page de détails du film en passant les informations nécessaires
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailFilm(
              moviesInfo: movieInfo, // Passer les informations sur le film sélectionné
            ),
          ),
        );
      },
      child: Card(
        color: Color(0xFF1E3243),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: Image.network(
                    movieInfo.imageUrl,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 200,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieInfo.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'res/svg/ic_movie_bicolor.svg',
                            width: 14,
                            height: 14,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${movieInfo.duree ?? ''} minutes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'res/svg/ic_calendar_bicolor.svg',
                            width: 14,
                            height: 14,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            movieInfo.releaseDate.isNotEmpty
                                ? movieInfo.releaseDate
                                .substring(0, min(4, movieInfo.releaseDate.length))
                                : '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              child: ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF8100)),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    '#${movieInfo.rank}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class MoviesBloc {
  final _moviesController = StreamController<List<MovieInfo>>();
  Stream<List<MovieInfo>> get moviesStream => _moviesController.stream;

  MoviesBloc() {
    loadMovies();
  }

  void loadMovies() async {
    try {
      print('Chargement des films en cours...');
      // Chargez les films depuis l'API ou une autre source de données
      final List<MoviesResponse> moviesListResponse = await ComicsRequest().loadMoviesList('movies');
      if (moviesListResponse.isNotEmpty) {
        final List<MovieInfo> movieInfoList = moviesListResponse.asMap().map((index, movie) {
          final movieInfo = MovieInfo(
            name: movie.name ?? '',
            releaseDate: movie.releaseDate ?? '',
            duree: movie.runtime ?? '',
            description: movie.description ?? '',
            imageUrl: movie.image?.screenUrl ?? '',
            rank: index + 1,
          );
          return MapEntry(index, movieInfo);
        }).values.toList();

        _moviesController.add(movieInfoList.take(50).toList());
      }
      else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des films : $e');
      _moviesController.addError('Erreur lors du chargement des films');
    }
  }
  void loadFirstFiveMovies() async {
    try {
      print('Chargement des films en cours...');
      // Chargez les films depuis l'API ou une autre source de données
      final List<MoviesResponse> moviesListResponse = await ComicsRequest().loadMoviesList('movies');
      if (moviesListResponse.isNotEmpty) {
        final List<MovieInfo> movieInfoList = moviesListResponse.asMap().map((index, movie) {
          final movieInfo = MovieInfo(
            name: movie.name ?? '',
            releaseDate: movie.releaseDate ?? '',
            duree: movie.runtime ?? '',
            description: movie.description ?? '',
            imageUrl: movie.image?.screenUrl ?? '',
            rank: index + 1,
          );
          return MapEntry(index, movieInfo);
        }).values.toList();

        _moviesController.add(movieInfoList.take(5).toList());
      }
      else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des films : $e');
      _moviesController.addError('Erreur lors du chargement des films');
    }
  }

  void dispose() {
    _moviesController.close();
  }
}

class MovieInfo {
  final String name;
  final String releaseDate;
  final String? duree;
  final String description;
  final String imageUrl;
  final int rank;

  MovieInfo({
    required this.name,
    required this.releaseDate,
    required this.duree,
    required this.description,
    required this.imageUrl,
    required this.rank,
  });
}


