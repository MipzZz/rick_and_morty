import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/app/model/app_theme.dart';
import 'package:rick_and_morty/features/settings/domain/repository/i_theme_repository.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required SettingsState initialState, required IThemeRepository themeRepository})
      : _themeRepository = themeRepository,
        super(initialState) {
    on<SettingsEvent>(
        (event, emitter) => switch (event) { SettingsEvent$UpdateThemeMode() => _updateTheme(event, emitter) });
  }

  final IThemeRepository _themeRepository;

  Future<void> _updateTheme(SettingsEvent$UpdateThemeMode event, Emitter<SettingsState> emitter) async {
    emitter(SettingsState$Processing(appTheme: state.appTheme));
    try {
      final newMode = state.appTheme.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      final updatedTheme = state.appTheme.copyWith(mode: newMode);
      await _themeRepository.setTheme(updatedTheme);
      emitter(SettingsState$Idle(appTheme: updatedTheme));
    } on Object catch (e, s) {
      emitter(SettingsState$Error(appTheme: state.appTheme, error: e));
      onError(e, s);
    }
  }
}
