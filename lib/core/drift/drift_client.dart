import 'package:drift/drift.dart';
import 'package:rick_and_morty/core/drift/database/app_drift_database.dart';
import 'package:rick_and_morty/core/drift/tables/cached_cards.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/filters_enum.dart';

final class DriftClientImpl implements IDriftClient {
  DriftClientImpl({required AppDriftDatabase database}) : _database = database;

  final AppDriftDatabase _database;

  late final _managers = _database.managers;

  @override
  Future<Iterable<Favorite>> getFavoritesCards({required Iterable<FilterEnum> filters}) async {
    final query = _database.select(_database.favoriteTable);
    final conditions = <Expression<bool>>[];

    if (filters.contains(FilterEnum.onlyWomen)) {
      conditions.add(_database.favoriteTable.gender.equals('Female'));
    }
    if (filters.contains(FilterEnum.onlyAlive)) {
      conditions.add(_database.favoriteTable.status.equals('Alive'));
    }

    if (conditions.isNotEmpty) {
      query.where((tbl) => conditions.reduce((a, b) => a & b));
    }

    final Iterable<Favorite> res = await query.get();

    return res;
  }

  @override
  Future<void> saveToFavorites(Favorite favorite) async {
    await _managers.favoriteTable.create(
      (o) => favorite,
    );
  }

  @override
  Future<void> removeFromFavorites(Favorite favorite) async {
    await _managers.favoriteTable.filter((f) => f.id.equals(favorite.id)).delete();
  }

  @override
  Future<Iterable<CachedCard>> getCachedCharacterCards() async {
    final query = _database.select(_database.cachedTable);
    final Iterable<CachedCard> res = await query.get();
    return res;
  }

  @override
  Future<void> saveCardsToCache({required Iterable<CachedCard> cards}) async {
    await _database.cachedTable.deleteAll();
    await _database.cachedTable.insertAll(cards);
  }
}

abstract interface class IDriftClient {
  Future<Iterable<Favorite>> getFavoritesCards({required Iterable<FilterEnum> filters});

  Future<void> saveToFavorites(Favorite favorite);

  Future<void> removeFromFavorites(Favorite favorite);

  Future<Iterable<CachedCard>> getCachedCharacterCards();

  Future<void> saveCardsToCache({required Iterable<CachedCard> cards});
}
