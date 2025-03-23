import 'package:rick_and_morty/core/drift/database/app_drift_database.dart';

final class DriftClientImpl implements DriftClient {
  DriftClientImpl({required $AppDriftDatabaseManager managers}) : _managers = managers;

  final $AppDriftDatabaseManager _managers;

  @override
  Future<List<Favorites>> getFavoritesCards() async {
    final res = await _managers.favoriteTable.get();
    return res;
  }

  @override
  Future<void> saveToFavorites(Favorites favorite) async {
    await _managers.favoriteTable.create(
      (_) => favorite,
    );
  }
}

abstract interface class DriftClient {
  Future<List<Favorites>> getFavoritesCards();

  Future<void> saveToFavorites(Favorites favorite);
}
