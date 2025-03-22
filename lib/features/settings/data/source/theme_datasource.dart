import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:rick_and_morty/core/utils/persisted_entry.dart';
import 'package:rick_and_morty/features/app/model/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeModeKey = 'theme.mode';

/// {@template theme_datasource}
/// [ThemeDataSource] is a data source that provides theme data.
///
/// This is used to set and get theme.
/// {@endtemplate}
abstract interface class ThemeDataSource {
  /// Set theme
  Future<void> setTheme(AppTheme theme);

  /// Get current theme from cache
  Future<AppTheme?> getTheme();
}

/// {@macro theme_datasource}
final class ThemeDataSourceLocal implements ThemeDataSource {
  /// {@macro theme_datasource}
  ThemeDataSourceLocal({
    required SharedPreferencesAsync sharedPreferences,
    required this.codec,
  }) : _themeMode = StringPreferencesEntry(sharedPreferences: sharedPreferences, key: _themeModeKey);

  /// Codec for [ThemeMode]
  final Codec<ThemeMode, String> codec;

  final StringPreferencesEntry _themeMode;

  @override
  Future<void> setTheme(AppTheme theme) async {
    await _themeMode.setIfNullRemove(codec.encode(theme.mode));
  }

  @override
  Future<AppTheme?> getTheme() async {
    final type = await _themeMode.read();

    if (type == null) return null;

    return AppTheme(mode: codec.decode(type));
  }
}
