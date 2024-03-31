import 'package:flutter/material.dart';
import 'package:application_comics/pages/details/liste_comics.dart'; // Make sure to use the correct import for ListeComics

class DetailComicHistoire extends StatefulWidget {
  @override
  _DetailComicHistoireState createState() => _DetailComicHistoireState();
}

class _DetailComicHistoireState extends State<DetailComicHistoire> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15232E),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ListeComics()), // Corrected redirection
            );
          },
        ),
        title: Text('The Silver Surfer', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Histoire'),
            Tab(text: 'Auteurs'), // Changed from 'Personnages'
            Tab(text: 'Personnages'), // Changed from 'Épisodes'
          ],
        ),
        backgroundColor: Color(0xFF15232E),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildHistoireTab(),
          _buildAuteursTab(), // This will be your authors tab
          _buildPersonnagesTab(), // Now contains character info, previously episodes
        ],
      ),
    );
  }

  Widget _buildHistoireTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 8.0),
                Text(
                  'In the Hands of... Mephisto!',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Expanded(child: Container()), // Spacer
                Text(
                  'N°16',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                SizedBox(width: 8.0),
                Text(
                  'Mai 1970',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'The Silver Surfer is a superhero in the Marvel Comics universe. Created by artist Jack Kirby, the character first appeared in Fantastic Four #48 in March 1966. The Silver Surfer, also known as Norrin Radd, is a cosmic being with superhuman powers. He is often associated with Galactus, a cosmic entity who feeds on the energy of planets. The Silver Surfer was chosen by Galactus to become his herald and travel the universe in search of planets to consume.The Silver Surfer has also been adapted in media beyond comic books. For example, he appeared in the film Fantastic Four: Rise of the Silver Surfer released in 2007. Additionally, there are rumors that Marvel Studios plans to develop a "Special Presentation" of the Silver Surfer on Disney+.The Silver Surfer is an iconic character in the Marvel universe, known for his cosmic adventures and philosophical reflections on the nature of existence and morality. He has also interacted with many other Marvel characters, such as the Avengers, the X-Men, and the Defenders.',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuteursTab() {
    final List<Map<String, dynamic>> auteurs = [
      {
        'name': 'Chic Stone',
        'title': 'Dessin',
        'image': 'assets/episode_101.jpg'
      },
      {
        'name': 'Josh Buscema',
        'title': 'Couverture',
        'image': 'assets/episode_102.jpg'
      },
      {
        'name': 'Sam Rosen',
        'title': 'Lettreur',
        'image': 'assets/episode_103.jpg'
      },
      {
        'name': 'Stan Lee',
        'title': 'Editeur, scénariste',
        'image': 'assets/episode_104.jpg'
      },
      // Plus d'episode API?
    ];

    return ListView.builder(
      itemCount: auteurs.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Color(0xFF1C1C1C),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: Image.asset(
              auteurs[index]['image'],
              fit: BoxFit.cover,
              width: 100.0,
              height: 56.0,
            ),
            title: Text(
              '${auteurs[index]['title']} - ${auteurs[index]['name']}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPersonnagesTab() {
    final List<Map<String, dynamic>> characters = [
      {'name': 'Dum DUm Dugam', 'avatar': 'assets/leo_fitz.jpg'},//REMPLACER LES LIENS IMAGES PAR LES PHOTOS DES PERSO
      {'name': 'Mephisto', 'avatar': 'assets/leo_fitz.jpg'},
      {'name': 'Nick Furry', 'avatar': 'assets/leo_fitz.jpg'},
      {'name': 'Shalla Bal', 'avatar': 'assets/leo_fitz.jpg'},
      {'name': 'Silver Surfer', 'avatar': 'assets/leo_fitz.jpg'},
      //Ajouter LA SUITE DES PERSONNAGES
    ];

    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(characters[index]['avatar']),
            backgroundColor: Colors.transparent,
          ),
          title: Text(
            characters[index]['name'],
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

}
}
