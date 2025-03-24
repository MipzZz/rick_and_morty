part of 'character_cards_bloc.dart';

@immutable
sealed class CharacterCardsState {
  final UnmodifiableListView<CharacterCard>? characterCards;
  final int? offset;

  const CharacterCardsState({this.offset, required this.characterCards});

  const factory CharacterCardsState.idle({
    int offset,
    required UnmodifiableListView<CharacterCard> characterCards,
  }) = CharacterCards$Idle;

  const factory CharacterCardsState.processing({
    int offset,
    required UnmodifiableListView<CharacterCard> characterCards,
  }) = CharacterCards$Processing;

  const factory CharacterCardsState.error({
    int offset,
    required UnmodifiableListView<CharacterCard> characterCards,
    required Object error,
  }) = CharacterCards$Error;
}

final class CharacterCards$Idle extends CharacterCardsState {
  const CharacterCards$Idle({super.offset, required super.characterCards});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharacterCards$Idle && other.characterCards == characterCards;
  }

  @override
  int get hashCode => characterCards.hashCode;
}

final class CharacterCards$Processing extends CharacterCardsState {
  const CharacterCards$Processing({super.offset, required super.characterCards});

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

  const CharacterCards$Error({
    super.offset,
    required super.characterCards,
    required this.error,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharacterCards$Error && other.characterCards == characterCards;
  }

  @override
  int get hashCode => characterCards.hashCode;
}
