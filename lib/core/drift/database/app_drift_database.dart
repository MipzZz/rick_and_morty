import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty/core/drift/tables/favorite_table.dart';

part 'app_drift_database.g.dart';

const _databaseName = 'rick_and_morty_db';

@DriftDatabase(tables: [FavoriteTable])
class AppDriftDatabase extends _$AppDriftDatabase {
  AppDriftDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: _databaseName,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
