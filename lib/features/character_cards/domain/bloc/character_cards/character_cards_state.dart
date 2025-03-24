part of 'character_cards_bloc.dart';

@immutable
sealed class CharacterCardsState {
  final UnmodifiableListView<CharacterCard>? characterCards;

  const CharacterCardsState({required this.characterCards});

  const factory CharacterCardsState.idle({required UnmodifiableListView<CharacterCard> characterCards}) =
      CharacterCards$Idle;

  const factory CharacterCardsState.processing({required UnmodifiableListView<CharacterCard> characterCards}) =
      CharacterCards$Processing;

  const factory CharacterCardsState.error({
    required UnmodifiableListView<CharacterCard> characterCards,
    required Object error,
  }) = CharacterCards$Error;
}

final class CharacterCards$Idle extends CharacterCardsState {
  const CharacterCards$Idle({required super.characterCards});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharacterCards$Idle && other.characterCards == characterCards;
  }

  @override
  int get hashCode => characterCards.hashCode;
}

final class CharacterCards$Processing extends CharacterCardsState {
  const CharacterCards$Processing({required super.characterCards});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharacterCards$Processing && other.characterCards == characterCards;
  }

  @override
  int get hashCode => characterCards.hashCode;
}

final class CharacterCards$Error extends CharacterCardsState {
  final Object error;

  const CharacterCards$Error({required super.characterCards, required this.error});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharacterCards$Error && other.characterCards == characterCards;
  }

  @override
  int get hashCode => characterCards.hashCode;
}
