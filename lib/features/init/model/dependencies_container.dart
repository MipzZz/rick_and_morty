import 'package:rick_and_morty/core/drift/drift_client.dart';
import 'package:rick_and_morty/core/rest_client/rest_client.dart';
import 'package:rick_and_morty/features/character_cards/domain/repository/i_character_cards_repository.dart';
import 'package:rick_and_morty/features/settings/domain/bloc/settings_bloc.dart';

/// {@template dependencies_container}
/// Container used to reuse dependencies across the application.
///
/// {@macro composition_process}
/// {@endtemplate}
class DependenciesContainer {
  /// {@macro dependencies_container}
  const DependenciesContainer({
    required this.settingsBloc,
    required this.restClient,
    required this.driftClient,
    required this.characterCardsRepository,
  });

  /// [AppSettingsBloc] instance, used to manage theme.
  final SettingsBloc settingsBloc;
  final RestClient restClient;
  final IDriftClient driftClient;
  final ICharacterCardsRepository characterCardsRepository;
}
