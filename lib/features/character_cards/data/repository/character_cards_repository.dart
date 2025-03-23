import 'package:rick_and_morty/features/character_cards/data/source/network/character_datasource.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/domain/repository/i_character_cards_repository.dart';

final class CharacterCardsRepository implements ICharacterCardsRepository {
  CharacterCardsRepository(CharacterDatasource characterDatasource) : _characterDatasource = characterDatasource;

  final CharacterDatasource _characterDatasource;

  @override
  Future<Iterable<CharacterCard>> getCharacterCards() async{
    final characterCards = await _characterDatasource.getCharacterCards();

    return characterCards;
  }
}