import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/subjects.dart'; // Importez les sujets de rxdart
import 'package:application_comics/comics_api.dart';
import 'package:application_comics/modele_API.dart';

class EpisodesBloc {
  final BehaviorSubject<List<EpisodesInfo>> _episodesController =
  BehaviorSubject<List<EpisodesInfo>>.seeded([]); // Initialisez avec une valeur initiale vide
  Stream<List<EpisodesInfo>> get episodestream => _episodesController.stream;

  EpisodesBloc() {
    loadEpisodes();
  }

  void loadEpisodes() async {
    try {
      print('Chargement des comics en cours...');
      // Chargez les comics depuis l'API ou une autre source de données
      final List<EpisodesResponse> episodesListResponse = await ComicsRequest().loadEpisodesList('episodes');
      if (episodesListResponse.isNotEmpty) {
        final List<EpisodesInfo> episodesInfoList = episodesListResponse.asMap().map((index, episode) {
          final episodesInfo = EpisodesInfo(
            name: episode.name ?? '',
            episodeNumber: episode.episodeNumber ?? '',
            date: episode.date?? '',
            imageUrl: episode.image?.screenUrl ?? '',
          );
          return MapEntry(index, episodesInfo);
        }).values.toList();

        _episodesController.add(episodesInfoList..toList());
      }
      else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des comics : $e');
      _episodesController.addError('Erreur lors du chargement des comics');
    }
  }

  void dispose() {
    _episodesController.close();
  }
}

class EpisodesInfo {
  final String name;
  final String episodeNumber;
  final String date;
  final String imageUrl;

  EpisodesInfo({
    required this.name,
    required this.episodeNumber,
    required this.date,
    required this.imageUrl,
  });
}
