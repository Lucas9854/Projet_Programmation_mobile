import 'package:flutter/material.dart';
import 'package:application_comics/Comics.dart';

class DetailComics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Détail Comics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF15232E),
        primaryColor: Color(0xFF15232E),
      ),
      home: ComicDetailPage(),
    );
  }
}

class ComicDetailPage extends StatefulWidget {
  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage> {
  int _selectedIndex = 0;
  final String histoireText =
      "The Silver Surfer, also known as Norrin Radd, is a fictional character appearing in American comic books published by Marvel Comics. The character originally appears as an antagonist in Fantastic Four #48, titled 'The Coming of Galactus!' (1966), but was soon reworked into a tragic hero in the subsequent issue.";
  final List<Map<String, String>> auteurs = [
    {'name': 'Stan Lee', 'image': 'assets/stan_lee.jpeg', 'poste': 'Writer'},
    {'name': 'Jack Kirby', 'image': 'assets/jack_kirby.jpeg', 'poste': 'Artist'},
    // Ajoutez d'autres auteurs ici
  ];
  final List<Map<String, String>> personnages = [
    {'name': 'Silver Surfer', 'image': 'assets/silver_perso.jpeg'},
    {'name': 'Dum Dum Dugan', 'image': 'assets/dum_dum_dugan.jpeg'},
    // Ajoutez d'autres personnages ici
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildTextSection(String text) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAuteurItem(String name, String image, String poste) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              poste,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ],
    ),
  );
}


  Widget _buildPersonnageItem(String name, String image) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ComicsPage()), // Assurez-vous d'avoir une SeriesPage
            );
          },
        ),
        title: Text('Détail Comics'),
        backgroundColor: Color(0xFF15232E),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Color(0xFF15232E),
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/silver_surfer.jpeg',
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The Silver Surfer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The Coming of Galactus!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.book, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            '#48',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            '1966',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFF15232E),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavBarItem(Icons.history, 'Histoire', 0),
                _buildNavBarItem(Icons.people, 'Auteurs', 1),
                _buildNavBarItem(Icons.person, 'Personnages', 2),
              ],
            ),
          ),
          Expanded(
            child: _selectedIndex == 0
                ? Container(
                    color: Color(0xFF1E3243),
                    child: _buildTextSection(histoireText),
                  )
                : _selectedIndex == 1
                    ? Container(
                        color: Color(0xFF1E3243),
                        child: _buildAuteursSection(auteurs),
                      )
                    : Container(
                        color: Color(0xFF1E3243),
                        child: _buildPersonnagesSection(personnages),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        children: [
          Icon(icon,
              color: _selectedIndex == index ? Colors.amber : Colors.white),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
                color: _selectedIndex == index ? Colors.amber : Colors.white),
          ),
          SizedBox(height: 4),
          Container(
            height: 3,
            width: 30,
            color: _selectedIndex == index ? Colors.amber : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildAuteursSection(List<Map<String, String>> auteurs) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: auteurs
            .map((auteur) => _buildAuteurItem(
                  auteur['name']!,
                  auteur['image']!,
                  auteur['poste']!,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPersonnagesSection(List<Map<String, String>> personnages) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: personnages
            .map((personnage) => _buildPersonnageItem(
                  personnage['name']!,
                  personnage['image']!,
                ))
            .toList(),
      ),
    );
  }
}

void main() {
  runApp(DetailComics());
}
