import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'DetailCharacterPage.dart';
import '../pagesPrincipales/Comics.dart';
import 'Characters.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class DetailComic extends StatefulWidget {
  final ComicInfo comicInfo;

  DetailComic({required this.comicInfo});

  @override
  _DetailComicState createState() => _DetailComicState();
}

class _DetailComicState extends State<DetailComic> {
  int _selectedIndex = 0;
  late CharactersBloc _charactersBloc;

  @override
  void initState() {
    super.initState();
    _charactersBloc = CharactersBloc();
  }

  @override
  void dispose() {
    _charactersBloc.dispose();
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
          widget.comicInfo.name,
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
                    widget.comicInfo.imageUrl,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mettez ici les détails de votre comic
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _selectedIndex == 0
                ? _buildHtmlSection(widget.comicInfo.description)
                : _selectedIndex == 1
                ? _buildCharactersSection()
                : SizedBox(),
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
}
