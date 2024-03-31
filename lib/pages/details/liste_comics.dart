import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListeComics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comics les plus populaires',
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
              title: 'The Silver Surfer',
              subtitle: 'In the Hands of ... Mephisto',
              leading: 'N°16',
              year: 'Mai 1970',
              imageUrl: 'SVG/silver',
            ),
            SerieTile(
              rank: '#2',
              title: 'Superman: The Man of',
              subtitle: 'The Underworld Rises Again',
              leading: 'N°17',
              year: 'Novembre 1992',
              imageUrl: 'SVG/superm',
            ),
            SerieTile(
              rank: '#3',
              title: 'The Uncanny X-Men',
              subtitle: 'Generation Next, Part 3: Enter Freely and of Your...',
              leading: 'N°317',
              year: 'Septembre 1994',
              imageUrl: 'SVG/uncanny',
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
  final String leading;
  final String year;
  final String imageUrl;

  const SerieTile({
    required this.rank,
    required this.title,
    required this.subtitle,
    required this.leading,
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
                      leading,
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
