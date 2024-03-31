import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Series.dart';
import '../main.dart';
import 'Comics.dart';
import 'Films.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isSearching = false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                        controller: _searchController,
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            _startSearch();
                          }
                        },
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
                  padding: EdgeInsets.all(70), // texte bien centré
                  decoration: BoxDecoration(
                    color: Color(0xFF1E3243),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _isSearching ? Text(
                    "Recherche en cours... merci de patienter",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1F9FFF),
                      fontSize: 18,
                    ),
                  ) : Text(
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
          _isSearching
              ? Positioned(
            right: 400, // Position apres
            top: 150,
            child: SvgPicture.asset('res/svg/astronaut_searching.svg', width: 140),
          )
              : Positioned(
            right: 206, //position avt
            top: 190,
            child: SvgPicture.asset('res/svg/astronaut.svg', width: 90),
          ),
        ],
      ),
      backgroundColor: Color(0xFF15232E),
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
}
