import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'dart:math';
import 'DetailComic.dart';
import 'package:application_comics/comics_api.dart';
import 'package:application_comics/modele_API.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'DetailComic.dart';

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
    return Card(
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
                          comicInfo.volumeName,
                          style: TextStyle(
                            fontSize: 14,
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
                  MaterialPageRoute(builder: (context) => DetailComics()), // Remplacez DetailComic() par le nom de votre page de détails de comic
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

  void dispose() {
    _comicsController.close();
  }
}

class ComicInfo {
  final String name;
  final String number;
  final String volumeName;
  final String coverDate;
  final String imageUrl;
  final int rank;

  ComicInfo({
    required this.name,
    required this.number,
    required this.volumeName,
    required this.coverDate,
    required this.imageUrl,
    required this.rank,
  });
}
