import 'dart:async';
import 'package:flutter/material.dart';
import 'pagesPrincipales/Series.dart';
import 'pagesPrincipales/Comics.dart';
import 'pagesPrincipales/Films.dart';
import 'pagesPrincipales/Recherche.dart';
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
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SeriesBloc _seriesBloc;
  late MoviesBloc _moviesBloc;
  late ComicsBloc _comicsBloc;

  @override
  void initState() {
    super.initState();
    _seriesBloc = SeriesBloc();
    _seriesBloc.loadFirstFiveSeries();

    _moviesBloc = MoviesBloc();
    _moviesBloc.loadFirstFiveMovies();

    _comicsBloc = ComicsBloc();
    _comicsBloc.loadFirstFiveComics();
  }

  @override
  void dispose() {
    _seriesBloc.dispose();
    _moviesBloc.dispose();
    _comicsBloc.dispose();
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

                Navigator.push(context, MaterialPageRoute(builder: (context) => MoviesPage()));
              },
            ),

            _buildSection(
              context,
              'Comics populaires',
              ComicsList(_comicsBloc.comicsStream),
                  () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => ComicsPage()));
              },
            ),

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
                MaterialPageRoute(builder: (context) => MyApp()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SeriesPage()),
              );
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
      stream: seriesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final seriesList = snapshot.data!;
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
              foregroundColor: Colors.white,
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

    return Container(
      width: 160.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(0xFF284C6A),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              child: Image.network(imageUrl, height: 100),
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

    return Container(
      width: 160.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(0xFF284C6A),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              child: Image.network(imageUrl, height: 100),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '${volume} #${number} - ${name}',
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
class FilmItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  FilmItem({required this.name, required this.imageUrl});
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 160.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(0xFF284C6A),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              child: Image.network(imageUrl, height: 100),
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