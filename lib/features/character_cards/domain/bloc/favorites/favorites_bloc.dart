import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/filters_enum.dart';
import 'package:rick_and_morty/features/character_cards/domain/repository/i_character_cards_repository.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required ICharacterCardsRepository characterCardsRepository})
      : _characterCardsRepository = characterCardsRepository,
        super(FavoritesState$Processing(favoritesCharacters: null)) {
    on<FavoritesEvent>((event, emitter) => switch (event) {
          FavoritesEvent$Load() => _load(event, emitter),
          FavoritesEvent$SaveToFavorites() => _saveToFavorites(event, emitter),
          FavoritesEvent$RemoveFromFavorites() => _removeFromFavorites(event, emitter)
        });
  }

  final ICharacterCardsRepository _characterCardsRepository;

  Future<void> _load(FavoritesEvent$Load event, Emitter<FavoritesState> emitter) async {
    emitter(FavoritesState$Processing(favoritesCharacters: state.favoritesCharacters));
    try {
      final favoritesCards = await _characterCardsRepository.getFavorites(filters: event.filters);
      emitter(FavoritesState$Idle(favoritesCharacters: UnmodifiableListView(favoritesCards)));
    } on Object catch (e, s) {
      emitter(FavoritesState$Error(favoritesCharacters: state.favoritesCharacters, error: e));
      onError(e, s);
    }
  }

  Future<void> _saveToFavorites(FavoritesEvent$SaveToFavorites event, Emitter<FavoritesState> emitter) async {
    emitter(FavoritesState$Processing(favoritesCharacters: state.favoritesCharacters));
    try {
      await _characterCardsRepository.saveToFavorites(event.characterCard);
      final updatedFavorites = UnmodifiableListView([...state.favoritesCharacters!, event.characterCard]);
      emitter(FavoritesState$Idle(favoritesCharacters: updatedFavorites));
    } on Object catch (e, s) {
      emitter(FavoritesState$Error(favoritesCharacters: state.favoritesCharacters, error: e));
      onError(e, s);
    }
  }

  Future<void> _removeFromFavorites(FavoritesEvent$RemoveFromFavorites event, Emitter<FavoritesState> emitter) async {
    emitter(FavoritesState$Processing(favoritesCharacters: state.favoritesCharacters));
    try {
      await _characterCardsRepository.removeFromFavorites(event.characterCard);
      final updatedFavorites =
          state.favoritesCharacters!.where((element) => element.id != event.characterCard.id).toList();
      emitter(FavoritesState$Idle(favoritesCharacters: UnmodifiableListView(updatedFavorites)));
    } on Object catch (e, s) {
      emitter(FavoritesState$Error(favoritesCharacters: state.favoritesCharacters, error: e));
      onError(e, s);
    }
  }
}
