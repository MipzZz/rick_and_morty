import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/common/url.dart';
import 'package:rick_and_morty/core/drift/database/app_drift_database.dart';
import 'package:rick_and_morty/core/drift/drift_client.dart';
import 'package:rick_and_morty/core/rest_client/app_dio_configurator.dart';
import 'package:rick_and_morty/core/rest_client/rest_client.dart';
import 'package:rick_and_morty/core/rest_client/rest_client_dio.dart';
import 'package:rick_and_morty/features/app/model/app_theme.dart';
import 'package:rick_and_morty/features/character_cards/data/repository/character_cards_repository.dart';
import 'package:rick_and_morty/features/character_cards/data/source/local/character_local_datasource.dart';
import 'package:rick_and_morty/features/character_cards/data/source/network/character_datasource.dart';
import 'package:rick_and_morty/features/character_cards/domain/repository/i_character_cards_repository.dart';
import 'package:rick_and_morty/features/init/model/dependencies_container.dart';
import 'package:rick_and_morty/features/settings/data/repository/theme_repository.dart';
import 'package:rick_and_morty/features/settings/data/source/theme_datasource.dart';
import 'package:rick_and_morty/features/settings/data/utils/theme_mode_codec.dart';
import 'package:rick_and_morty/features/settings/domain/bloc/settings_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template composition_root}
/// A place where top-level dependencies are initialized.
/// {@endtemplate}
final class CompositionRoot {
  /// {@macro composition_root}
  const CompositionRoot();

  Future<DependenciesContainer> compose() async {
    final dependencies = await createDependenciesContainer();

    return dependencies;
  }
}

/// {@template composition_result}
/// Result of composition.
///
/// {@macro composition_process}
/// {@endtemplate}
final class CompositionResult {
  /// {@macro composition_result}
  const CompositionResult({required this.dependencies});

  final DependenciesContainer dependencies;
}

/// Creates the full dependencies container.
Future<DependenciesContainer> createDependenciesContainer() async {
  final sharedPreferences = SharedPreferencesAsync();
  final appSettingsBloc = await createSettingsBloc(sharedPreferences);
  final restClient = await createRestClient();
  final driftClient = await createDriftClient();
  final characterCardsRepository = await createCharacterCardsRepository(
    restClient: restClient,
    driftClient: driftClient,
  );

  return DependenciesContainer(
    settingsBloc: appSettingsBloc,
    restClient: restClient,
    driftClient: driftClient,
    characterCardsRepository: characterCardsRepository,
  );
}

/// Creates an instance of [AppSettingsBloc].
///
/// The [AppSettingsBloc] is initialized at startup to load the app settings from local storage.
Future<SettingsBloc> createSettingsBloc(SharedPreferencesAsync sharedPreferences) async {
  final themeCodec = ThemeModeCodec();
  final themeRepository =
      ThemeRepository(themeDataSource: ThemeDataSourceLocal(sharedPreferences: sharedPreferences, codec: themeCodec));

  final appTheme = await themeRepository.getTheme();
  final initialState = SettingsState$Idle(appTheme: appTheme ?? AppTheme(mode: ThemeMode.light));

  return SettingsBloc(themeRepository: themeRepository, initialState: initialState);
}

Future<RestClient> createRestClient() async {
  final dioConfigurator = AppDioConfigurator();
  final dioClient = dioConfigurator.create(url: Url.baseUrl);

  return RestClientDio(dio: dioClient);
}

Future<DriftClient> createDriftClient() async {
  final driftDatabase = AppDriftDatabase();
  return DriftClientImpl(database: driftDatabase);
}

Future<ICharacterCardsRepository> createCharacterCardsRepository(
    {required RestClient restClient, required DriftClient driftClient}) async {
  final characterDatasource = CharacterDatasource(restClient);
  final characterLocalDatasource = CharacterLocalDatasource(driftClient);

  return CharacterCardsRepository(
    characterDatasource: characterDatasource,
    characterLocalDatasource: characterLocalDatasource,
  );
}
