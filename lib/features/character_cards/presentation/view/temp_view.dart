import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/navigation/utils/app_route_paths.dart';
import 'package:rick_and_morty/features/settings/domain/bloc/settings_bloc.dart';
import 'package:rick_and_morty/features/navigation/router.dart' as router;

/// {@template TempView.class}
/// TempView widget.
/// {@endtemplate}
class TempView extends StatefulWidget {
  /// {@macro TempView.class}
  const TempView({super.key});

  @override
  State<TempView> createState() => _TempViewState();
}

class _TempViewState extends State<TempView> {
  late int _currentIndex;
  late final List<_Tab> _tabs;
  late final GlobalKey<NavigatorState> _navigatorKey;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _tabs = [
      _Tab(title: 'Главная', path: AppRoutePaths.cards),
      _Tab(title: 'Избранное', path: AppRoutePaths.favorites)
    ];
    _navigatorKey = GlobalKey();
  }

  void changeTab(int index) {
    setState(() => _currentIndex = index);
    _navigatorKey.currentState!.pushReplacementNamed(_tabs[index].path);
  }

  void changeTheme(BuildContext context) {
    final themeMode = context.read<SettingsBloc>().state.appTheme.mode;
    context
        .read<SettingsBloc>()
        .add(SettingsEvent$UpdateThemeMode(themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_tabs[_currentIndex].title),
        actions: [
          IconButton(onPressed: () => changeTheme(context), icon: const Icon(Icons.dark_mode)),
        ],
      ),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: AppRoutePaths.cards,
        onGenerateRoute: router.generateRoute,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: changeTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: _tabs[0].title),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: _tabs[1].title),
        ],
      ),
    );
  }
}

final class _Tab {
  final String title;
  final String path;

  const _Tab({required this.title, required this.path});
}
