import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:application_comics/comics_api.dart';
import 'package:application_comics/modele_API.dart';
import 'Series.dart';
import 'Comics.dart';
import 'Films.dart';
import 'Recherche.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accueil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xFF15232E),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF15232E),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0x778BA8),
        ),
        fontFamily: 'Nunito',
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(), // Appel de la méthode MyHomePage ici
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SeriesBloc _seriesBloc;
  late MoviesBloc _moviesBloc; // Ajout de MoviesBloc
  late ComicsBloc _comicsBloc; // Ajout de ComicsBloc

  @override
  void initState() {
    super.initState();
    _seriesBloc = SeriesBloc();
    _seriesBloc.loadFirstFiveSeries();

    _moviesBloc = MoviesBloc(); // Initialisation de MoviesBloc
    _moviesBloc.loadFirstFiveMovies(); // Chargement des premiers cinq films

    _comicsBloc = ComicsBloc(); // Initialisation de ComicsBloc
    _comicsBloc.loadFirstFiveComics(); // Chargement des premiers cinq comics
  }

  @override
  void dispose() {
    _seriesBloc.dispose();
    _moviesBloc.dispose(); // Dispose de MoviesBloc
    _comicsBloc.dispose(); // Dispose de ComicsBloc
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              color: Color(0xFF15232E),
              height: 150.0,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bienvenue !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: -65,
                    child: SvgPicture.asset('res/svg/astronaut.svg', height: 200),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildSection(
              context,
              'Séries populaires',
              SeriesList(_seriesBloc.seriesStream),
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesPage())),
            ),
            // Section des films
            _buildSection(
              context,
              'Films populaires',
              MoviesList(_moviesBloc.moviesStream),
                  () {
                // Naviguez vers la page des films lorsque l'utilisateur appuie sur "Voir plus"
                Navigator.push(context, MaterialPageRoute(builder: (context) => MoviesPage()));
              },
            ),
            // Section des comics
            _buildSection(
              context,
              'Comics populaires',
              ComicsList(_comicsBloc.comicsStream), // Utilisation de ComicsList avec le flux de comics
                  () {
                // Naviguez vers la page des comics lorsque l'utilisateur appuie sur "Voir plus"
                Navigator.push(context, MaterialPageRoute(builder: (context) => ComicsPage()));
              },
            ),
            // Autres sections
            SizedBox(height: 20),
          ],
        ),
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
    );
  }

  // Méthode pour construire une section avec un titre, du contenu et un bouton "Voir plus"
  Widget _buildSection(BuildContext context, String title, Widget content, VoidCallback onPressed) {
    return Container(
      color: Color(0xFF1E3243),
      child: Column(
        children: [
          SectionHeader(title: title, onPressed: onPressed),
          content,
        ],
      ),
    );
  }
}

class SeriesList extends StatelessWidget {
  final Stream<List<SeriesInfo>> seriesStream;

  SeriesList(this.seriesStream);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SeriesInfo>>(
      stream: seriesStream, // Utilisez le flux de données seriesStream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Affichez un indicateur de chargement en attendant les données
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}'); // Affichez un message d'erreur s'il y a une erreur
        } else if (snapshot.hasData) {
          final seriesList = snapshot.data!; // Récupérez les données
          return Container(
            height: 150.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: seriesList.length,
              itemBuilder: (context, index) {
                final series = seriesList[index];
                return SeriesItem(name: series.name, imageUrl: series.imageUrl);
              },
            ),
          );
        } else {
          return SizedBox(); // Placeholder
        }
      },
    );
  }
}
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  SectionHeader({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: Color(0xFFFF8100),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          TextButton(
            child: Text('Voir plus'),
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, // Use foregroundColor instead of primary for text color
              backgroundColor: Color(0xFF0F1921),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            ),
          ),
        ],
      ),
    );
  }
}

class ComicsList extends StatelessWidget {
  final Stream<List<ComicInfo>> comicsStream;

  ComicsList(this.comicsStream);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ComicInfo>>(
      stream: comicsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final comicsList = snapshot.data!;
          return Container(
            height: 150.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: comicsList.length,
              itemBuilder: (context, index) {
                final comic = comicsList[index];
                return ComicsItem(volume: comic.volumeName, number: comic.number, name: comic.name , imageUrl: comic.imageUrl,);
              },
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
class MoviesList extends StatelessWidget {
  final Stream<List<MovieInfo>> moviesStream;

  MoviesList(this.moviesStream);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MovieInfo>>(
      stream: moviesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final moviesList = snapshot.data!;
          return Container(
            height: 150.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moviesList.length,
              itemBuilder: (context, index) {
                final movie = moviesList[index];
                return FilmItem(name: movie.name, imageUrl: movie.imageUrl);
              },
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class SeriesItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  SeriesItem({required this.name, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    // Utiliser un Container pour définir des dimensions fixes
    return Container(
      width: 160.0, // Largeur fixe pour chaque élément
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(0xFF284C6A),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Cela garantit que la colonne prend la hauteur minimale de son contenu
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              child: Image.network(imageUrl, height: 100), // Utilisez Image.network pour charger l'image à partir de l'URL
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ComicsItem extends StatelessWidget {
  final String volume;
  final String number ;
  final String name ;
  final String imageUrl;
  ComicsItem({required this.volume, required this.number, required this.name, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    // Utiliser un Container pour définir des dimensions fixes
    return Container(
      width: 160.0, // Largeur fixe pour chaque élément
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(0xFF284C6A),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Pour que la colonne prenne la hauteur minimale de son contenu
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              child: Image.network(imageUrl, height: 100), // Hauteur fixe pour l'image
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '${volume} #${number} - ${name}',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center, // Centrer le titre
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class FilmItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  FilmItem({required this.name, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    // Utiliser un Container pour définir des dimensions fixes
    return Container(
      width: 160.0, // Largeur fixe pour chaque élément
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(0xFF284C6A),

        child: Column(
          mainAxisSize: MainAxisSize.min, // Pour que la colonne prenne la hauteur minimale de son contenu
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              child: Image.network(imageUrl, height: 100), // Hauteur fixe pour l'image
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center, // Centrer le titre
              ),
            ),
          ],
        ),
      ),
    );
  }
}