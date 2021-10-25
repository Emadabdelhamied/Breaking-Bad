import 'package:breakingbad/data/models/character.dart';
import 'package:breakingbad/data/models/quote.dart';
import 'package:breakingbad/data/webServices/charactersWebServices.dart';
import 'package:flutter/material.dart';

class CharactersRepository {
  final CharacterWebServices characterWebServices;
  CharactersRepository(this.characterWebServices);
  Future<List<Character>> getAllCharacters() async {
    final characters = await characterWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getCharQuote(String charName) async {
    final quotes = await characterWebServices.getCharQuote(charName);
    return quotes
        .map((charQuote) => Quote.fromJson(charQuote))
        .toList();
  }
}
