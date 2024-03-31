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
    // Simulez la fin de la recherche avec un délai
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isSearching = false;
      });
    });
    // Ajoutez ici votre logique de recherche réelle
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
                  padding: EdgeInsets.all(80), // Ajusté pour que le texte soit bien centré
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
            right: 400, //astro recherche
            top: 160,
            child: SvgPicture.asset('res/svg/astronaut_searching.svg', width: 140),
          )
              : Positioned(
            right: 186, // astro avant
            top: 190,
            child: SvgPicture.asset('res/svg/astronaut.svg', width: 100),
          ),
        ],
      ),
      backgroundColor: Color(0xFF15232E),
    );
  }
}
