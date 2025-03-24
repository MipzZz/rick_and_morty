import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/filters_enum.dart';

abstract interface class ICharacterCardsRepository {
  Future<Iterable<CharacterCard>> getCharacterCards({required int? offset, required Iterable<FilterEnum> filters});
  Future<Iterable<CharacterCard>> getFavorites({required Iterable<FilterEnum> filters});
  Future<void> saveToFavorites(CharacterCard characterCard);
  Future<void> removeFromFavorites(CharacterCard characterCard);

}
