import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'DetailCharacterPage.dart';
import '../pagesPrincipales/Films.dart';
import 'Characters.dart';
import 'Episodes.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class DetailFilm extends StatefulWidget {
  final MovieInfo moviesInfo;

  DetailFilm({required this.moviesInfo});

  @override
  _DetailFilmState createState() => _DetailFilmState();
}

class _DetailFilmState extends State<DetailFilm> {
  int _selectedIndex = 0;
  late CharactersBloc _charactersBloc;
  late EpisodesBloc _episodesBloc;

  @override
  void initState() {  //initialisation
    super.initState();
    _charactersBloc = CharactersBloc();
    _episodesBloc = EpisodesBloc();
  }

  @override
  void dispose() {
    _charactersBloc.dispose();
    _episodesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.moviesInfo.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF15232E),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Color(0xFF15232E),
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.moviesInfo.imageUrl,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mettez ici les détails de votre série
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _selectedIndex == 0
                ? _buildHtmlSection(widget.moviesInfo.description)
                : _selectedIndex == 1
                ? _buildCharactersSection()
                : _buildEpisodesSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Détails',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Personnages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Épisodes',
          ),
        ],
        backgroundColor: Color(0xFF15232E),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHtmlSection(String htmlContent) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: HtmlWidget(
          htmlContent,
          textStyle: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildCharactersSection() {
    return StreamBuilder<List<CharactersInfo>>(
      stream: _charactersBloc.characterStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final characters = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPerso(
                        name: character.name,
                        image: character.imageUrl,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(character.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.name,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text('Aucun personnage disponible.'));
        }
      },
    );
  }

  Widget _buildEpisodesSection() {
    return StreamBuilder<List<EpisodesInfo>>(
      stream: _episodesBloc.episodestream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final episodes = snapshot.data!;
          return Container(
            color: Color(0xFF15232E),
            padding: EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: episodes.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final episode = episodes[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFF1E3243),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(episode.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                episode.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Épisode ${episode.episodeNumber} - ${episode
                                    .date}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: Text('Aucun épisode disponible.'));
        }
      },
    );
  }
}
