part of 'bad_breaking_cubit.dart';

@immutable
abstract class BadBreakingState {}

class BadBreakingInitial extends BadBreakingState {}

class CharacterLoaded extends BadBreakingState {
  final List<Character> characters;
  CharacterLoaded(this.characters);
}
class CharacterLoading extends BadBreakingState {}
class CharacterErrorLoading extends BadBreakingState {
  final String error;
  CharacterErrorLoading(this.error);
}

class QuoteLoaded extends BadBreakingState {
  final List<Quote> quote;
  QuoteLoaded(this.quote);
}

class ChangeAppBar extends BadBreakingState{}
