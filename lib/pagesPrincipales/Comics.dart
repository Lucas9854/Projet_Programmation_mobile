import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'dart:math';
import '../pagesDetail/DetailComicPage.dart';
import 'package:application_comics/API/API_request.dart';
import 'package:application_comics/API/API_model.dart';
import 'Series.dart';
import '../main.dart';
import 'Films.dart';
import 'Recherche.dart';

class ComicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF15232E),
      ),
      home: ComicsListPage(),
    );
  }
}

class ComicsListPage extends StatelessWidget {
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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('res/svg/navbar_home.svg', width: 24, height: 24, color : Color(0xFF778BA8)),
            label: 'Accueil',

          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('res/svg/navbar_series.svg', width: 24, height: 24,color : Color(0xFF778BA8)),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('res/svg/navbar_comics.svg', width: 24, height: 24,color : Color(0xFF778BA8)),
            label: 'Comics',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('res/svg/navbar_movies.svg', width: 24, height: 24,color : Color(0xFF778BA8)),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('res/svg/navbar_search.svg', width: 24, height: 24,color : Color(0xFF778BA8)),
            label: 'Recherche',
          ),
        ],
        backgroundColor: Color(0xFF0F1E2B),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {

          switch (index) {
            case 0: // Accueil
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()), // Naviguer vers la page d'accueil
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SeriesPage()),
              ); // Naviguer vers la page des séries
              break;
            case 2: // Comics
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ComicsPage()),
              );
              break;
            case 3: // Films
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MoviesPage()),
              );
              break;
            case 4: // Recherche
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
              break;
            default:
          }
        },
      ),
      body: ComicsListWidget(),
      // BottomNavigationBar reste inchangé
    );
  }
}

class ComicsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ComicInfo>>(
      stream: ComicsBloc().comicsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final List<ComicInfo> comicInfoList = snapshot.data!;
          return ListView.builder(
            itemCount: comicInfoList.length,
            itemBuilder: (context, index) {
              final ComicInfo comicInfo = comicInfoList[index];
              return ComicWidget(
                comicInfo: comicInfo,
              );
            },
          );
        } else {
          return SizedBox(); // Placeholder
        }
      },
    );
  }
}

class ComicWidget extends StatelessWidget {
  final ComicInfo comicInfo;

  ComicWidget({
    required this.comicInfo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigation vers la page de détails du comic
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailComic(comicInfo: comicInfo)),
        );
      },
      child: Card(
        color: Color(0xFF1E3243),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: Image.network(
                    comicInfo.imageUrl,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 200,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comicInfo.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        comicInfo.volumeName,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic, // Ajout de l'italique
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'res/svg/ic_publisher_bicolor.svg',
                            width: 14,
                            height: 14,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'N°${comicInfo.number}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'res/svg/ic_calendar_bicolor.svg',
                            width: 14,
                            height: 14,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            comicInfo.coverDate.isNotEmpty ? comicInfo.coverDate.substring(0, min(4, comicInfo.coverDate.length)) : 'Date indisponible', // Affiche les 4 premiers caractères de la date de publication
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              child: ElevatedButton(
                onPressed: () {
                  // Navigation vers la page de détails du comic
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailComic(comicInfo: comicInfo)),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF8100)),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    '#${comicInfo.rank}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class ComicsBloc {
  final _comicsController = StreamController<List<ComicInfo>>();
  Stream<List<ComicInfo>> get comicsStream => _comicsController.stream;

  ComicsBloc() {
    loadComics();
  }

  void loadComics() async {
    try {
      print('Chargement des comics en cours...');
      // Chargez les comics depuis l'API ou une autre source de données
      final List<ComicsResponse> comicsListResponse = await ComicsRequest().loadComicsList('issues');
      if (comicsListResponse.isNotEmpty) {
        final List<ComicInfo> comicInfoList = comicsListResponse.asMap().map((index, comic) {
          final comicInfo = ComicInfo(
            name: comic.name ?? '',
            number: comic.issuesNumber?? '',
            volumeName: comic.volume?.name ?? '',
            coverDate : comic.coverDate ?? '',
            description: comic.description ?? '',
            imageUrl: comic.image?.screenUrl ?? '',
            rank: index + 1,
          );
          return MapEntry(index, comicInfo);
        }).values.toList();

        _comicsController.add(comicInfoList.take(50).toList());
      }
      else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des comics : $e');
      _comicsController.addError('Erreur lors du chargement des comics');
    }
  }
  void loadFirstFiveComics() async {
    try {
      print('Chargement des comics en cours...');
      // Chargez les comics depuis l'API ou une autre source de données
      final List<ComicsResponse> comicsListResponse = await ComicsRequest().loadComicsList('issues');
      if (comicsListResponse.isNotEmpty) {
        final List<ComicInfo> comicInfoList = comicsListResponse.asMap().map((index, comic) {
          final comicInfo = ComicInfo(
            name: comic.name ?? '',
            number: comic.issuesNumber?? '',
            volumeName: comic.volume?.name ?? '',
            coverDate : comic.coverDate ?? '',
            description: comic.description ?? '',
            imageUrl: comic.image?.screenUrl ?? '',
            rank: index + 1,
          );
          return MapEntry(index, comicInfo);
        }).values.toList();

        _comicsController.add(comicInfoList.take(5).toList());
      }
      else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des comics : $e');
      _comicsController.addError('Erreur lors du chargement des comics');
    }
  }

  void dispose() {
    _comicsController.close();
  }
}

class ComicInfo {
  final String name;
  final String number;
  final String volumeName;
  final String coverDate;
  final String description;
  final String imageUrl;
  final int rank;

  ComicInfo({
    required this.name,
    required this.number,
    required this.volumeName,
    required this.coverDate,
    required this.description,
    required this.imageUrl,
    required this.rank,
  });
}
