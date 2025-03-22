// import 'package:logger/logger.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:sizzle_starter/src/core/common/error_reporter/error_reporter.dart';
// import 'package:sizzle_starter/src/core/constant/application_config.dart';
// import 'package:sizzle_starter/src/feature/settings/bloc/app_settings_bloc.dart';

import 'package:rick_and_morty/features/settings/domain/bloc/settings_bloc.dart';

/// {@template dependencies_container}
/// Container used to reuse dependencies across the application.
///
/// {@macro composition_process}
/// {@endtemplate}
class DependenciesContainer {
  /// {@macro dependencies_container}
  const DependenciesContainer({required this.settingsBloc});

  /// [AppSettingsBloc] instance, used to manage theme.
  final SettingsBloc settingsBloc;
}
