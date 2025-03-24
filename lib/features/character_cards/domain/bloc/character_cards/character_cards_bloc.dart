import 'dart:collection';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/filters_enum.dart';
import 'package:rick_and_morty/features/character_cards/domain/repository/i_character_cards_repository.dart';

part 'character_cards_event.dart';

part 'character_cards_state.dart';

class CharacterCardsBloc extends Bloc<CharacterCardsEvent, CharacterCardsState> {
  CharacterCardsBloc({required ICharacterCardsRepository characterCardsRepository})
      : _characterCardsRepository = characterCardsRepository,
        super(CharacterCards$Processing(characterCards: null)) {
    on<CharacterCardsEvent>((event, emitter) => switch (event) { CharacterCardsEvent$Load() => _load(event, emitter) });
  }

  final ICharacterCardsRepository _characterCardsRepository;

  Future<void> _load(CharacterCardsEvent$Load event, Emitter<CharacterCardsState> emitter) async {
    emitter(CharacterCards$Processing(offset: state.offset, characterCards: event.offset == null ? state.characterCards : null));
    try {
      final characterCardsChunk =
          await _characterCardsRepository.getCharacterCards(offset: event.offset ?? state.offset, filters: event.filters);
      final UnmodifiableListView<CharacterCard> newCardsList = UnmodifiableListView([...(state.characterCards ?? []), ...characterCardsChunk]);//.distinct().toList();
      // // TODO(MipZ): Возвращать новый офсет с апи
      emitter(CharacterCards$Idle(characterCards: newCardsList, offset: (state.offset ?? 1) + 1));
    } on Object catch (e, s) {
      emitter(CharacterCards$Error(characterCards: state.characterCards, error: e));
      onError(e, s);
    }
  }
}
