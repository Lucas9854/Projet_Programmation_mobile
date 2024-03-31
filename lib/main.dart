
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:application_comics/pages/details/liste_series.dart';
import 'package:application_comics/pages/details/liste_comics.dart';
import 'package:application_comics/pages/details/liste_films.dart';
import 'package:application_comics/pages/details/details_serie_histoire.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appli Projet',
      debugShowCheckedModeBanner: false,
      home: DetailSerieHistoire(), //ListeSeries ListeComics ListeFilms CHANGER EN FONCTION DE LA PAGE SOUHAITE, il faut les appeler lorsque l'on selectionne la page voulu


    );
  }
}

