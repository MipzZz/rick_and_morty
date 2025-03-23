import 'package:rick_and_morty/features/character_cards/data/source/local/character_local_datasource.dart';
import 'package:rick_and_morty/features/character_cards/data/source/network/character_datasource.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
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
  Future<Iterable<CharacterCard>> getCharacterCards() async {
    final characterCards = await _characterDatasource.getCharacterCards();

    return characterCards;
  }

  @override
  Future<Iterable<CharacterCard>> getFavorites() async {
    final favoriteCards = await _characterLocalDatasource.getFavoritesCards();

    return favoriteCards;
  }

  @override
  Future<void> saveToFavorites(CharacterCard characterCard) async {
    await _characterLocalDatasource.saveToFavorites(characterCard);
  }
}
