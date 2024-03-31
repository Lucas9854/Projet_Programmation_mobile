import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    // Ici, vous lancerez votre logique de recherche.
    // Par exemple, vous pouvez attendre une réponse d'une API.
    // Une fois la recherche terminée, vous définissez `_isSearching` sur false.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche',
        style: TextStyle(color: Colors.white), // Text color of AppBar
        ),
        backgroundColor: Color(0xFF15232E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _searchController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _startSearch();
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Comic, film, série...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _startSearch();
                    }
                  },
                ),
                 enabledBorder: UnderlineInputBorder(      
                  borderSide: BorderSide(color: Colors.white70),   // Color of the enabled border
                ),  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Color of the focused border
                ),
              ),
            ),
            if (!_isSearching)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      'Saisissez une recherche pour trouver un comics, film, série ou personnage.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                    Spacer(flex: 2),
                    SvgPicture.asset('assets/astronaut.svg', height: 200),
                  ],
                ),
              ),
            if (_isSearching)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Recherche en cours. Merci de patienter...',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 20),
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    SvgPicture.asset('assets/astronaut.svg', height: 200),
                  ],
                ),
              ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF15232E),
    );
  }
}
