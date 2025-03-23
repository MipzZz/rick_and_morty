part of 'character_cards_bloc.dart';

@immutable
sealed class CharacterCardsState {
  final UnmodifiableListView<CharacterCard>? _characterCards;

  const CharacterCardsState(this._characterCards);

  UnmodifiableListView<CharacterCard>? get characterCards => _characterCards;
}

final class CharacterCards$Idle extends CharacterCardsState {
  const CharacterCards$Idle(super.characterCards);
}
final class CharacterCards$Processing extends CharacterCardsState {
  const CharacterCards$Processing(super.characterCards);
}
final class CharacterCards$Error extends CharacterCardsState {
  final Object error;
  const CharacterCards$Error(super.characterCards, {required this.error});
}
