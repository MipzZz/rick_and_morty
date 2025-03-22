import 'package:flutter/foundation.dart' show immutable;
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
        (event, emitter) => switch (event) { SettingsEvent$UpdateTheme() => _updateTheme(event, emitter) });
  }

  final IThemeRepository _themeRepository;

  Future<void> _updateTheme(SettingsEvent$UpdateTheme event, Emitter<SettingsState> emitter) async {
    emitter(SettingsState$Processing(state.appTheme));
    try {
      await _themeRepository.setTheme(event.theme);
      emitter(SettingsState$Idle(event.theme));
    } on Object catch (e, s) {
      emitter(SettingsState$Error(state.appTheme, error: e));
      onError(e, s);
    }
  }

  // TODO(MipZ): Can add locale and textScale
}
