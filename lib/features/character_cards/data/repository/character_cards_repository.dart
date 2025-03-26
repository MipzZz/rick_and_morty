import 'package:rick_and_morty/features/character_cards/data/source/local/character_local_datasource.dart';
import 'package:rick_and_morty/features/character_cards/data/source/network/character_datasource.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/filters_enum.dart';
import 'package:rick_and_morty/features/character_cards/domain/repository/i_character_cards_repository.dart';

final class CharacterCardsRepository implements ICharacterCardsRepository {
  CharacterCardsRepository({
    required CharacterDatasource characterDatasource,
    required CharacterLocalDatasource characterLocalDatasource,
  })  : _characterDatasource = characterDatasource,
        _characterLocalDatasource = characterLocalDatasource;

  final CharacterDatasource _characterDatasource;
  final CharacterLocalDatasource _characterLocalDatasource;

  @override
  Future<Iterable<CharacterCard>> getCharacterCards({
    required int? offset,
    required Iterable<FilterEnum> filters,
  }) async {
    final characterCards = await _characterDatasource.getCharacterCards(offset: offset, filters: filters);
    // Сохраняем только первую страницу
    if (offset == 1) await _characterLocalDatasource.cacheCharacterCards(characterCards: characterCards);
    return characterCards;
  }

  @override
  Future<Iterable<CharacterCard>> getFavorites({required Iterable<FilterEnum> filters}) async {
    final favoriteCards = await _characterLocalDatasource.getFavoritesCards(filters: filters);

    return favoriteCards;
  }

  @override
  Future<void> saveToFavorites(CharacterCard characterCard) async {
    await _characterLocalDatasource.saveToFavorites(characterCard);
  }

  @override
  Future<void> removeFromFavorites(CharacterCard characterCard) async {
    await _characterLocalDatasource.removeFromFavorites(characterCard);
  }

  @override
  Future<void> saveCardsToCache({required Iterable<CharacterCard> characterCards}) async {
    await _characterLocalDatasource.cacheCharacterCards(characterCards: characterCards);
  }

  @override
  Future<Iterable<CharacterCard>> getCachedCards() async {
    final cachedCharacterCards = await _characterLocalDatasource.getCachedCharacterCards();
    return cachedCharacterCards;
  }
}
