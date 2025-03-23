part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {
  final AppTheme appTheme;

  const SettingsState({required this.appTheme});

  const factory SettingsState.idle({required AppTheme appTheme}) = SettingsState$Idle;

  const factory SettingsState.processing({required AppTheme appTheme}) = SettingsState$Processing;

  const factory SettingsState.error({required AppTheme appTheme, required Object error}) = SettingsState$Error;
}

final class SettingsState$Idle extends SettingsState {
  const SettingsState$Idle({required super.appTheme});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsState$Idle && other.appTheme == appTheme;
  }

  @override
  int get hashCode => appTheme.hashCode;
}

final class SettingsState$Processing extends SettingsState {
  const SettingsState$Processing({required super.appTheme});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsState$Processing && other.appTheme == appTheme;
  }

  @override
  int get hashCode => appTheme.hashCode;
}

final class SettingsState$Error extends SettingsState {
  final Object error;

  const SettingsState$Error({required super.appTheme, required this.error});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsState$Error && other.appTheme == appTheme;
  }

  @override
  int get hashCode => appTheme.hashCode;
}
