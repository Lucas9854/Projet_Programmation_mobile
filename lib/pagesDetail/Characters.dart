import 'package:flutter/material.dart';
import 'dart:async';
import 'package:application_comics/API/API_request.dart';
import 'package:application_comics/API/API_model.dart';
import 'package:rxdart/subjects.dart'; // Importez les sujets de rxdart

class CharactersBloc {
  final BehaviorSubject<List<CharactersInfo>> _charactersController =
  BehaviorSubject<List<CharactersInfo>>.seeded([]); // Initialisez avec une valeur initiale vide
  Stream<List<CharactersInfo>> get characterStream => _charactersController.stream;

  CharactersBloc() {
    loadCharacters(); // Chargement des personnages
  }

  void loadCharacters() async {
    try {
      print('Chargement des comics en cours...');
      // Chargement des comics depuis l'API
      final List<CharactersResponse> charactersListResponse = await ComicsRequest().loadCharactersList('characters');
      if (charactersListResponse.isNotEmpty) {
        final List<CharactersInfo> charactersInfoList = charactersListResponse.asMap().map((index, character) {
          final charactersInfo = CharactersInfo(
            name: character.name ?? '',
            realName: character.realName?? '',
            alias: character.aliases?? '',
            description : character.deck ?? '',
            gender : character.gender ?? 2,
            birth : character.birth ?? '',
            imageUrl: character.image?.screenUrl ?? '',
          );
          return MapEntry(index, charactersInfo);
        }).values.toList();

        _charactersController.add(charactersInfoList.toList());
      }
      else {
        print('La réponse de l\'API est vide.');
      }
    } catch (e) {
      print('Erreur lors du chargement des comics : $e');
      _charactersController.addError('Erreur lors du chargement des comics');
    }
  }

  void dispose() {
    _charactersController.close();
  }
}

class CharactersInfo {
  final String name;
  final String realName;
  final String alias;
  final String description;
  final int gender;
  final String birth;
  final String imageUrl;

  CharactersInfo({
    required this.name,
    required this.realName,
    required this.alias,
    required this.description,
    required this.gender,
    required this.birth,
    required this.imageUrl,
  });
}