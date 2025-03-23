import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/domain/repository/i_character_cards_repository.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required ICharacterCardsRepository characterCardsRepository})
      : _characterCardsRepository = characterCardsRepository,
        super(FavoritesState$Processing(null)) {
    on<FavoritesEvent>((event, emitter) =>
    switch (event) {
      FavoritesEvent$Load() => _load(event, emitter),
      FavoritesEvent$SaveToFavorites() => _saveToFavorites(event, emitter),
    });
  }

  final ICharacterCardsRepository _characterCardsRepository;

  Future<void> _load(FavoritesEvent$Load event, Emitter<FavoritesState> emitter) async {
    emitter(FavoritesState$Processing(state.favoritesCharacters));
    try {
      final favoritesCards = await _characterCardsRepository.getFavorites();
      emitter(FavoritesState$Idle(UnmodifiableListView(favoritesCards)));
    } on Object catch (e, s) {
      emitter(FavoritesState$Error(state.favoritesCharacters, error: e));
      onError(e, s);
    }
  }

  Future<void> _saveToFavorites(FavoritesEvent$SaveToFavorites event, Emitter<FavoritesState> emitter) async {
    emitter(FavoritesState$Processing(state.favoritesCharacters));
    try {
      await _characterCardsRepository.saveToFavorites(event.characterCard);
      emitter(FavoritesState$Idle(state.favoritesCharacters));
    } on Object catch (e, s) {
      emitter(FavoritesState$Error(state.favoritesCharacters, error: e));
      onError(e, s);
    }
  }
}