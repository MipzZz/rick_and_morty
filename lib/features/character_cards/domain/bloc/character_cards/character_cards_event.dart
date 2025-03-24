part of 'character_cards_bloc.dart';

@immutable
sealed class CharacterCardsEvent {}

class CharacterCardsEvent$Load extends CharacterCardsEvent {
  final List<FilterEnum> filters;
  final int? offset;

  CharacterCardsEvent$Load({this.offset, required this.filters});
}
