part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {
  final AppTheme _appTheme;

  const SettingsState(this._appTheme);

  AppTheme get appTheme => _appTheme;
}

final class SettingsState$Idle extends SettingsState {


  const SettingsState$Idle(super.appTheme);
}

final class SettingsState$Processing extends SettingsState {

  const SettingsState$Processing(super.appTheme);
}

final class SettingsState$Error extends SettingsState {
  final Object error;

  const SettingsState$Error(super.appTheme, {required this.error});
}
