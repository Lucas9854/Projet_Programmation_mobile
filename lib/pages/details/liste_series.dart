import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListeSeries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Séries les plus populaires',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF15232E),
      ),
      body: Container(
        color: Color(0xFF15232E),
        child: ListView(
          children: <Widget>[
            SerieTile(
              rank: '#1',
              title: 'Agents of Shield',
              subtitle: 'Marvel',
              episodeInfo: '136 épisodes',
              year: '2013',
              imageUrl: 'SVG/agentsofshield.png',
            ),
            SerieTile(
              rank: '#2',
              title: 'Arrow',
              subtitle: 'DC Comics',
              episodeInfo: '170 épisodes',
              year: '2012',
              imageUrl: 'SVG/arrow.png',
            ),
            SerieTile(
              rank: '#3',
              title: 'Wolverine and the X-Men',
              subtitle: 'Marvel',
              episodeInfo: '26 épisodes',
              year: '2008',
              imageUrl: 'SVG/wolverine.png',
            ),
            SerieTile(
              rank: '#4',
              title: 'The X-Files',
              subtitle: 'Drame',
              episodeInfo: '218 épisodes',
              year: '1993',
              imageUrl: 'SVG/xfiles.png',
            ),

            //RAJOUTER POUR D AUTRES SERIES


          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Comics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
        ],
        backgroundColor: Color(0xFF15232E),
        selectedItemColor: Color(0xFF12273C),
        unselectedItemColor: Color(0xFF778BA8),
      ),
    );
  }
}

class SerieTile extends StatelessWidget {
  final String rank;
  final String title;
  final String subtitle;
  final String episodeInfo;
  final String year;
  final String imageUrl;

  const SerieTile({
    required this.rank,
    required this.title,
    required this.subtitle,
    required this.episodeInfo,
    required this.year,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF1E3243),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      episodeInfo,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      year,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
