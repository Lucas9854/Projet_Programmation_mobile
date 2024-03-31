import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:application_comics/API/API_request.dart';
import 'package:application_comics/API/API_model.dart';
import '../pagesDetail/DetailSeriePage.dart';
import 'Films.dart';
import '../main.dart';
import 'Comics.dart';
import 'Recherche.dart';


class SeriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Series',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF15232E),
      ),
      home: HomePage(),
    );
  }
}


class SeriesInfo {

  final String name;
  final String publisherName;
  final int countOfEpisodes;
  final String startYear;
  final String imageUrl;
  final String description;
  final int rank;

  SeriesInfo({

    required this.name,
    required this.publisherName,
    required this.countOfEpisodes,
    required this.startYear,
    required this.imageUrl,
    required this.description,
    required this.rank,
  });
}

class SeriesBloc {
  final _seriesController = StreamController<List<SeriesInfo>>();
  Stream<List<SeriesInfo>> get seriesStream => _seriesController.stream;

  SeriesBloc() {
    loadSeries();
  }

  void loadSeries() async {
    try {
      print('Chargement des séries en cours...');
      final List<SeriesResponse> seriesListResponse =
      await ComicsRequest().loadSeriesList('series_list');
      if (seriesListResponse.isNotEmpty) {
        final List<SeriesInfo> seriesInfoList = seriesListResponse.asMap().map((index, series) {
          final seriesInfo = SeriesInfo(
            name: series.name,
            publisherName: series.publisher?.name ?? '',
            countOfEpisodes: series.countOfEpisodes,
            startYear: series.startYear,
            imageUrl: series.image?.screenUrl ?? '',
            description: series.description ?? '',
            rank: index + 1,
          );
          return MapEntry(index, seriesInfo);
        }).values.toList();

        _seriesController.add(seriesInfoList.take(50).toList());
      }
      else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des séries : $e');
      _seriesController.addError('Erreur lors du chargement des séries');
    }
  }
  void loadFirstFiveSeries() async {
    try {
      print('Chargement des séries en cours...');
      final List<SeriesResponse> seriesListResponse =
      await ComicsRequest().loadSeriesList('series_list');
      if (seriesListResponse.isNotEmpty) {
        final List<SeriesInfo> seriesInfoList = seriesListResponse.asMap().map((index, series) {
          final seriesInfo = SeriesInfo(
            name: series.name,
            publisherName: series.publisher?.name ?? '',
            countOfEpisodes: series.countOfEpisodes,
            startYear: series.startYear,
            imageUrl: series.image?.screenUrl ?? '',
            description: series.description ?? '',
            rank: index + 1,
          );
          return MapEntry(index, seriesInfo);
        }).values.toList();

        _seriesController.add(seriesInfoList.take(5).toList());
      }
      else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des séries : $e');
      _seriesController.addError('Erreur lors du chargement des séries');
    }
  }


  void dispose() {
    _seriesController.close();
  }
}

class HomePage extends StatelessWidget {
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
                MaterialPageRoute(builder: (context) => MyApp()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SeriesPage()),
              );
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
      body: StreamBuilder<List<SeriesInfo>>(
        stream: SeriesBloc().seriesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<SeriesInfo> seriesInfoList = snapshot.data!;
            return ListView.builder(
              itemCount: seriesInfoList.length,
              itemBuilder: (context, index) {
                final SeriesInfo seriesInfo = seriesInfoList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailSerie(seriesInfo: seriesInfo)),
                    );
                  },
                  child: SeriesInfoWidget(
                    seriesInfo: seriesInfo,

                    onTap: () {
                    },
                  ),
                );
              },
            );
          } else {
            return SizedBox(); // Placeholder
          }
        },
      ),
    );
  }
}





class SeriesInfoWidget extends StatelessWidget {
  final SeriesInfo seriesInfo;
  final VoidCallback onTap;

  const SeriesInfoWidget({
    Key? key,
    required this.seriesInfo,
    required this.onTap,
  }) : super(key: key);

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
                  seriesInfo.imageUrl,
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
                      seriesInfo.name,
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
                          seriesInfo.publisherName,
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
                          'res/svg/ic_TV_bicolor.svg',
                          width: 14,
                          height: 14,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${seriesInfo.countOfEpisodes} épisodes',
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
                          seriesInfo.startYear,
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
              onPressed: onTap,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF8100)),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '#${seriesInfo.rank}',
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
