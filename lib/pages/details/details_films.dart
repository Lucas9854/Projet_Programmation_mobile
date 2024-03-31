import 'package:flutter/material.dart';
import 'package:application_comics/pages/details/liste_films.dart';

class DetailFilmsHistoire extends StatefulWidget {
  @override
  _DetailFilmsHistoireState createState() => _DetailFilmsHistoireState();
}

class _DetailFilmsHistoireState extends State<DetailFilmsHistoire> with SingleTickerProviderStateMixin {
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
              MaterialPageRoute(builder: (context) => ListeFilms()),
            );
          },
        ),
        title: Text('Watchmen', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Synopsis'),
            Tab(text: 'Personnages'),
            Tab(text: 'Info'),
          ],
        ),
        backgroundColor: Color(0xFF15232E),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildSynopsisTab(),
          _buildPersonnagesTab(),
          _buildInfosTab(),
        ],
      ),
    );
  }

  Widget _buildSynopsisTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: Container()), // Spacer
                Text(
                  '162 minutes',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                SizedBox(width: 8.0),
                Text(
                  '2009',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'The watchmen follows a group of retired superheros, as they attempt to foil a plot to kill off masked superheroes. As they race to find the killer, the Doomsday clock draws closer to Nuclear War. Soon they find themselves entangled in a web of lies and deceit, that just might save humanity, but at what cost. And just how far will they go to save the world? ',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonnagesTab() {
    final List<Map<String, dynamic>> characters = [
      {'name': 'Andy Warhot', 'avatar': 'assets/jemma_simmons.jpg'},
      {'name': 'Bernard', 'avatar': 'assets/quake.jpg'},
      {'name': 'Big Figure', 'avatar': 'assets/melinda_may.jpg'},
      {'name': 'Bubastis', 'avatar': 'assets/phil_coulson.jpg'},
      {'name': 'Captain Metropolis', 'avatar': 'assets/leo_fitz.jpg'},
      {'name': 'David Bowie', 'avatar': 'assets/al_mackenzie.jpg'},

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

  Widget _buildInfosTab() {
    final List<Map<String, dynamic>> infos = [
      {
        'title': 'Classification',
        'name': 'R',
      },
      {
        'title': 'Réalisateur',
        'name': 'Zack Snyder',
      },
      {
        'title': 'Scénaristes',
        'name': 'Alex Tse, David Hayter',
      },
      {
        'title': 'Producteurs',
        'name': 'Deborah Snyder, Lawrence Gordon, Lloyd Levin, Wesley Collier',
      },
      // Plus infos API?
    ];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Color(0xFF1C1C1C),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            title: Text(
              '${infos[index]['title']} - ${infos[index]['name']}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
