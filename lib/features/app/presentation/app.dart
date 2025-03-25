import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/app/model/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/character_cards/character_cards_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/favorites/favorites_bloc.dart';
import 'package:rick_and_morty/features/init/logic/dependencies_scope.dart';
import 'package:rick_and_morty/features/init/model/dependencies_container.dart';
import 'package:rick_and_morty/features/navigation/utils/app_route_paths.dart';
import 'package:rick_and_morty/features/settings/domain/bloc/settings_bloc.dart';
import 'package:rick_and_morty/features/navigation/router.dart' as router;

/// {@template App.class}
/// App widget.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro AppM.class}
  const App(this.dependencies, {super.key});

  final DependenciesContainer dependencies;

  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: dependencies,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(create: (_) => dependencies.settingsBloc),
          BlocProvider<CharacterCardsBloc>(
            create: (context) {
              return CharacterCardsBloc(characterCardsRepository: dependencies.characterCardsRepository)
                ..add(CharacterCardsEvent$Load(filters: [], offset: 1));
            },
          ),
          BlocProvider(
              create: (context) => FavoritesBloc(characterCardsRepository: dependencies.characterCardsRepository)
                ..add(FavoritesEvent$Load(filters: []))),
        ],
        child: Builder(builder: (context) {
          final appTheme = context.select<SettingsBloc, AppTheme>((bloc) => bloc.state.appTheme);
          return MaterialApp(
              theme: appTheme.lightTheme,
              darkTheme: appTheme.darkTheme,
              themeMode: appTheme.mode,
              initialRoute: AppRoutePaths.home,
              onGenerateRoute: router.generateRoute,
              builder: (context, child) => child!);
        }),
      ),
    );
  }
}
