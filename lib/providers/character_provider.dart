import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marvel_app/models/response_model.dart';
import 'package:marvel_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_app/utils/debouncer.dart';

class CharacterProvider extends ChangeNotifier {
  List<Result> characters = [];
  Map<int,Result>  details = {};

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500)
  );

  final StreamController<List<Result>> _suggestionsStreamController = StreamController.broadcast();

  Stream<List<Result>> get suggestionStream => _suggestionsStreamController.stream;

  Future<void> fetchCharacters({int limit = 100, int offset = 0}) async {
    final String url =
        '${Constants.baseUrl}characters?apikey=${Constants.marvelAPIPublicKey}&ts=1&hash=${Constants.generateMarvelAPIHash()}&limit=$limit&offset=$offset';
    final Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final responseModel = ResponseModel.fromMap(data);
        if (responseModel.data != null && responseModel.data!.results != null) {
          characters = responseModel.data!.results!.toList();
        } else {
          print('Error parsing response data.');
        }
        notifyListeners();
      } else {
        print('Error fetching characters. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching characters: $e');
    }
  }

   Future<Result> fetchCharacterDetailsById(int characterId) async {
    final String url =
        '${Constants.baseUrl}characters/$characterId?apikey=${Constants.marvelAPIPublicKey}&ts=1&hash=${Constants.generateMarvelAPIHash()}';
    final Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final characterDetails = Result.fromMap(data["data"]["results"][0]);
        details[characterId] = characterDetails; // Almacena los detalles usando el characterId como clave
        notifyListeners();
        return characterDetails;
      } else {
        throw Exception(
            'Error fetching character details. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching character details: $e');
    }
  }

 Future<List<Result>> searchCharacters(String query) async {
  final encodedQuery = Uri.encodeComponent(query);
  final url = '${Constants.baseUrl}characters?apikey=${Constants.marvelAPIPublicKey}&ts=1&hash=${Constants.generateMarvelAPIHash()}&nameStartsWith=$encodedQuery';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> results = data['data']['results'];
      final List<Result> searchResults = results.map((json) => Result.fromMap(json)).toList();
      return searchResults;
    } else {
      throw Exception('Error searching characters. Response code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error searching characters: $e');
  }
}


  void getSuggestionsByQuery(String searchTerm){
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchCharacters(value);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(
      const Duration(milliseconds: 300),
      (_) { 
        debouncer.value = searchTerm; 
      }
    );
    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
