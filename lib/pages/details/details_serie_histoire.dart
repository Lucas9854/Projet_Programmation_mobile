import 'package:flutter/material.dart';
import 'package:application_comics/pages/details/liste_series.dart';

class DetailSerieHistoire extends StatefulWidget {
  @override
  _DetailSerieHistoireState createState() => _DetailSerieHistoireState();
}

class _DetailSerieHistoireState extends State<DetailSerieHistoire> with SingleTickerProviderStateMixin {
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
              MaterialPageRoute(builder: (context) => ListeSeries()),
            );
          },
        ),
        title: Text('Agents of S.H.I.E.L.D.', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Histoire'),
            Tab(text: 'Personnages'),
            Tab(text: 'Épisodes'),
          ],
        ),
        backgroundColor: Color(0xFF15232E),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildHistoireTab(),
          _buildPersonnagesTab(),
          _buildEpisodesTab(),
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
                  'Marvel',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Expanded(child: Container()), // Spacer
                Text(
                  '136 épisodes',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                SizedBox(width: 8.0),
                Text(
                  '2013',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'The missions of the Strategic Homeland Intervention, Enforcement and Logistics Division. A small team of operatives led by Agent Coulson (Clark Gregg) who must deal with the strange new world of "superheroes" after the "Battle of New York", protecting the public from new and unknown threats.',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonnagesTab() {
    final List<Map<String, dynamic>> characters = [
      {'name': 'Jemma Simmons', 'avatar': 'assets/jemma_simmons.jpg'},
      {'name': 'Quake', 'avatar': 'assets/quake.jpg'},
      {'name': 'Melinda May', 'avatar': 'assets/melinda_may.jpg'},
      {'name': 'Phil Coulson', 'avatar': 'assets/phil_coulson.jpg'},
      {'name': 'Leo Fitz', 'avatar': 'assets/leo_fitz.jpg'},
      {'name': 'Al Mackenzie', 'avatar': 'assets/al_mackenzie.jpg'},
      {'name': 'Stingshot', 'avatar': 'assets/stingshot.jpg'},
      {'name': 'Grant Ward', 'avatar': 'assets/grant_ward.jpg'},
      {'name': 'Lance Hunter', 'avatar': 'assets/lance_hunter.jpg'},
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

  Widget _buildEpisodesTab() {
    final List<Map<String, dynamic>> episodes = [
      {
        'title': 'Episode #101',
        'name': 'Pilot',
        'airDate': '24 septembre 2013',
        'image': 'assets/episode_101.jpg'
      },
      {
        'title': 'Episode #102',
        'name': '0-8-4',
        'airDate': '1 octobre 2013',
        'image': 'assets/episode_102.jpg'
      },
      {
        'title': 'Episode #103',
        'name': 'The Asset',
        'airDate': '8 octobre 2013',
        'image': 'assets/episode_103.jpg'
      },
      {
        'title': 'Episode #104',
        'name': 'Eye Spy',
        'airDate': '15 octobre 2013',
        'image': 'assets/episode_104.jpg'
      },
      // Plus d'episode API?
    ];

    return ListView.builder(
      itemCount: episodes.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Color(0xFF1C1C1C),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: Image.asset(
              episodes[index]['image'],
              fit: BoxFit.cover,
              width: 100.0,
              height: 56.0,
            ),
            title: Text(
              '${episodes[index]['title']} - ${episodes[index]['name']}',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              episodes[index]['airDate'],
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
          ),
        );
      },
    );
  }
}