import 'package:drift/drift.dart';

@DataClassName('CachedCard')
class CachedTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  TextColumn get type => text()();
  TextColumn get gender => text()();
  TextColumn get image => text()();
}
