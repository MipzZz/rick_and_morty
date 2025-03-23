import 'dart:collection';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/domain/repository/i_character_cards_repository.dart';

part 'character_cards_event.dart';

part 'character_cards_state.dart';

class CharacterCardsBloc extends Bloc<CharacterCardsEvent, CharacterCardsState> {
  CharacterCardsBloc({required ICharacterCardsRepository characterCardsRepository})
      : _characterCardsRepository = characterCardsRepository,
        super(CharacterCards$Processing(null)) {
    on<CharacterCardsEvent>((event, emitter) => switch (event) { CharacterCardsEvent$Load() => _load(event, emitter) });
  }

  final ICharacterCardsRepository _characterCardsRepository;

  Future<void> _load(CharacterCardsEvent$Load event, Emitter<CharacterCardsState> emitter) async {
    emitter(CharacterCards$Processing(state.characterCards));
    try {
      final characterCards = await _characterCardsRepository.getCharacterCards();
      emitter(CharacterCards$Idle(UnmodifiableListView(characterCards)));
    } on Object catch (e, s) {
      emitter(CharacterCards$Error(state.characterCards, error: e));
      onError(e, s);
    }
  }
}
