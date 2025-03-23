import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';

abstract interface class ICharacterCardsRepository {
  Future<Iterable<CharacterCard>> getCharacterCards();
  Future<Iterable<CharacterCard>> getFavorites();
  Future<void> saveToFavorites(CharacterCard characterCard);
  Future<void> removeFromFavorites(CharacterCard characterCard);

}
