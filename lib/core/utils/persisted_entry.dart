import 'package:shared_preferences/shared_preferences.dart';

/// {@template shared_preferences_entry}
/// [SharedPreferencesEntry] describes a single persisted entry in [SharedPreferences].
/// {@endtemplate}
abstract class SharedPreferencesEntry<T extends Object> {
  /// {@macro shared_preferences_entry}
  const SharedPreferencesEntry({required this.sharedPreferences, required this.key});

  /// The instance of [SharedPreferences] used to read and write values.
  final SharedPreferencesAsync sharedPreferences;

  /// The key used to store the value in the cache.
  final String key;

  /// Read the value from the cache.
  Future<T?> read();

  /// Set the value in the cache.
  Future<void> set(T value);

  /// Remove the value from the cache.
  Future<void> remove();

  /// Set the value in the cache if the value is not null, otherwise remove the value from the cache.
  Future<void> setIfNullRemove(T? value) => value == null ? remove() : set(value);
}

/// A [int] implementation of [SharedPreferencesEntry].
class IntPreferencesEntry extends SharedPreferencesEntry<int> {
  /// {@macro int_preferences_entry}
  const IntPreferencesEntry({required super.sharedPreferences, required super.key});

  @override
  Future<int?> read() => sharedPreferences.getInt(key);

  @override
  Future<void> set(int value) async {
    await sharedPreferences.setInt(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}

/// A [String] implementation of [SharedPreferencesEntry].
class StringPreferencesEntry extends SharedPreferencesEntry<String> {
  /// {@macro string_preferences_entry}
  const StringPreferencesEntry({required super.sharedPreferences, required super.key});

  @override
  Future<String?> read() => sharedPreferences.getString(key);

  @override
  Future<void> set(String value) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  Future<void> remove() async {
    await sharedPreferences.remove(key);
  }
}
