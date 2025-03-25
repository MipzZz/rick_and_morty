import 'package:rick_and_morty/core/rest_client/rest_client.dart';
import 'package:rick_and_morty/core/utils/typdef.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/filters_enum.dart';

final class CharacterDatasource {
  CharacterDatasource(this._restClient);

  final RestClient _restClient;

  Future<Iterable<CharacterCard>> getCharacterCards({
    required int? offset,
    required Iterable<FilterEnum> filters,
  }) async {
    await Future.delayed(Duration(seconds: 5));
    final res = await _restClient.get('/character', queryParams: {
      'status': filters.contains(FilterEnum.onlyAlive) ? 'alive' : null,
      'gender': filters.contains(FilterEnum.onlyWomen) ? 'female' : null,
      'page': offset,
    });
    if (res == null) return [];

    final itemsMap = (res['results'] as List<dynamic>? ?? []).cast<JsonMap>();

    return itemsMap.map((jsonCharacter) => CharacterCard.fromJson(jsonCharacter));
  }
}
