import 'package:rick_and_morty/core/drift/drift_client.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/filters_enum.dart';

final class CharacterLocalDatasource {
  CharacterLocalDatasource(this.driftClient);

  final DriftClient driftClient;

  Future<Iterable<CharacterCard>> getFavoritesCards({required Iterable<FilterEnum> filters}) async{
    final res = await driftClient.getFavoritesCards(filters: filters);
    final characterFavoriteCards = res.map(CharacterCard.fromFavorites);
    return characterFavoriteCards;
  }

  Future<void> saveToFavorites(CharacterCard characterCard) async{
    await driftClient.saveToFavorites(characterCard.toFavorites());
  }

  Future<void> removeFromFavorites(CharacterCard characterCard) async{
    await driftClient.removeFromFavorites(characterCard.toFavorites());
  }
}