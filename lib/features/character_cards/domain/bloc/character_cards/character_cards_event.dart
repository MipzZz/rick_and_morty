part of 'character_cards_bloc.dart';

@immutable
sealed class CharacterCardsEvent {}

class CharacterCardsEvent$Load extends CharacterCardsEvent {
  final List<Filter> filters;

  CharacterCardsEvent$Load({required this.filters});
}
