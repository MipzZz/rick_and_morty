part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

final class SettingsEvent$UpdateThemeMode extends SettingsEvent {
  final ThemeMode themeMode;

  SettingsEvent$UpdateThemeMode(this.themeMode);
}
