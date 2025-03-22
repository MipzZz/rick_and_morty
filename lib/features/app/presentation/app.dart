import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/app/model/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/presentation/view/cards_view.dart';
import 'package:rick_and_morty/features/init/logic/dependencies_scope.dart';
import 'package:rick_and_morty/features/init/model/dependencies_container.dart';
import 'package:rick_and_morty/features/settings/domain/bloc/settings_bloc.dart';
import 'package:rick_and_morty/main.dart';

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
        ],
        child: Builder(builder: (context) {
          final appTheme = context.select<SettingsBloc, AppTheme>((bloc) => bloc.state.appTheme);
          return MaterialApp(
              theme: appTheme.lightTheme,
              darkTheme: appTheme.darkTheme,
              themeMode: appTheme.mode,
              home: CardsView(),
              // TODO(MipZ): Add routes
              // routes: ,
              builder: (context, child) => child!);
        }),
      ),
    );
  }
}
