import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Series.dart';
import 'main.dart';
import 'Comics.dart';
import 'Films.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche'),
        backgroundColor: Color(0xFF15232E),
      ),
      body: SearchBody(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF223141),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recherche',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Comic, film, série...',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                        suffixIcon: Icon(Icons.search, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFF15232E),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 120),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF1E3243),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Saisissez une recherche pour trouver un comics, film, série ou personnage.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1F9FFF),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          top: 200,
          child: SvgPicture.asset('res/svg/astronaut.svg', width: 80),
        ),
      ],
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          case 4:
            break;
          default:
        }
      },
    );
  }
}
