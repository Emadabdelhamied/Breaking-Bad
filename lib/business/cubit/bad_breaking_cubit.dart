import 'package:bloc/bloc.dart';
import 'package:breakingbad/data/models/character.dart';
import 'package:breakingbad/data/models/quote.dart';
import 'package:breakingbad/data/repository/charactersRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'bad_breaking_state.dart';

class BadBreakingCubit extends Cubit<BadBreakingState> {
  final CharactersRepository charactersRepository;

  List<Character> characters;

  BadBreakingCubit(this.charactersRepository) : super(BadBreakingInitial());

  static BadBreakingCubit get(context) => BlocProvider.of(context);

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      this.characters = characters;
      emit(CharacterLoaded(characters));
    });
  }

  void getCharQuote(String charName) {
    charactersRepository.getCharQuote(charName).then((quote) {
      emit(QuoteLoaded(quote));
    });
  }
}
