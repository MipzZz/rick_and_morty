part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

final class SettingsEvent$UpdateTheme extends SettingsEvent {
  final AppTheme theme;

  SettingsEvent$UpdateTheme(this.theme);
}
