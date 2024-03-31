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

class AstronautLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'res/svg/astronaut.svg',
      semanticsLabel: 'Logo ',
      height: 170, // La hauteur que vous souhaitez pour votre logo
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accueil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xFF15232E), //Couleur arriere plan

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF15232E), // Couleur NavBar
          selectedItemColor: Colors.white, // Couleur des éléments sélectionnés
          unselectedItemColor: Color(0x778BA8), // Couleur des éléments non sélectionnés
        ),

        fontFamily: 'Nunito',
        // Pour les titres, par exemple
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
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
            _buildSection(context, 'Séries populaires', SeriesList(), () => Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesPage()))),
            _buildSection(context, 'Comics populaires', ComicsList(), () => Navigator.push(context, MaterialPageRoute(builder: (context) => ComicsPage()))),
            _buildSection(context, 'Films populaires', FilmList(), () => Navigator.push(context, MaterialPageRoute(builder: (context) => MoviesPage()))),
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
        selectedItemColor: Color(0xFF12273C),
        unselectedItemColor: Color(0xFF778BA8),
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

  Widget _buildSection(BuildContext context, String title, Widget content,VoidCallback onPressed) {
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SeriesItem(title: 'Titans', assetName: 'S1.png'),
          SeriesItem(title: 'Young Justice: Outsiders', assetName: 'S2.png'),
          SeriesItem(title: 'Autre série', assetName: 'S3.jpeg'),
          // Ajoutez d'autres éléments ici si nécessaire
        ],
      ),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          ComicsItem(title: 'The Silver Surfer', assetName: 'C1.png'),
          ComicsItem(title: 'Wonder Woman #89', assetName: 'C2.png'),
          ComicsItem(title: 'Autre comic', assetName: 'C3.jpeg'), // Supposons que C3.png soit un autre asset
          // Ajoutez d'autres éléments ici si nécessaire
        ],
      ),
    );
  }
}
class FilmList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          FilmItem(title: 'Iron Man', assetName: 'F1.png'),
          FilmItem(title: 'X-Men', assetName: 'F2.png'),
          FilmItem(title: 'Autre film', assetName: 'F3.jpeg'),
          // Ajoutez d'autres éléments ici si nécessaire
        ],
      ),
    );
  }
}
class SeriesItem extends StatelessWidget {
  final String title;
  final String assetName;
  SeriesItem({required this.title, required this.assetName});
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
              child: Image.asset('assets/$assetName', height: 100), // Hauteur fixe pour l'image
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                title,
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
  final String title;
  final String assetName;
  ComicsItem({required this.title, required this.assetName});
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
              child: Image.asset('assets/$assetName', height: 100), // Hauteur fixe pour l'image
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                title,
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
  final String title;
  final String assetName;
  FilmItem({required this.title, required this.assetName});
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
              child: Image.asset('assets/$assetName', height: 100), // Hauteur fixe pour l'image
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                title,
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
