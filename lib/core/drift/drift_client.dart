import 'package:drift/drift.dart';
import 'package:rick_and_morty/core/drift/database/app_drift_database.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/filters_enum.dart';

final class DriftClientImpl implements DriftClient {
  DriftClientImpl({required AppDriftDatabase database}) : _database = database;

  final AppDriftDatabase _database;

  late final _managers = _database.managers;

  @override
  Future<List<Favorites>> getFavoritesCards({required Iterable<FilterEnum> filters}) async {
    final query = _database.select(_database.favoriteTable);
    final conditions = <Expression<bool>>[];

    if (filters.contains(FilterEnum.onlyWomen)) {
      conditions.add(_database.favoriteTable.gender.equals('Female'));
    }
    if (filters.contains(FilterEnum.onlyAlive)) {
      conditions.add(_database.favoriteTable.status.equals('Alive'));
    }

    if (conditions.isNotEmpty) {
      // Объединяем все условия через логический оператор И (AND)
      query.where((tbl) => conditions.reduce((a, b) => a & b));
    }

    final List<Favorites> res = await query.get();

    return res;
  }


  @override
  Future<void> saveToFavorites(Favorites favorite) async {
    await _managers.favoriteTable.create(
      (o) => favorite,
    );
  }

  @override
  Future<void> removeFromFavorites(Favorites favorite) async {
    await _managers.favoriteTable.filter((f) => f.id.equals(favorite.id)).delete();
  }
}

abstract interface class DriftClient {
  Future<List<Favorites>> getFavoritesCards({required Iterable<FilterEnum> filters});

  Future<void> saveToFavorites(Favorites favorite);

  Future<void> removeFromFavorites(Favorites favorite);
}
