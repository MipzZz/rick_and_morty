import 'package:rick_and_morty/core/drift/drift_client.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';

final class CharacterLocalDatasource {
  CharacterLocalDatasource(this.driftClient);

  final DriftClient driftClient;

  Future<Iterable<CharacterCard>> getFavoritesCards() async{
    final res = await driftClient.getFavoritesCards();
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