import 'package:flutter/material.dart';

/// {@template TempView.class}
/// TempView widget.
/// {@endtemplate}
class TempView extends StatefulWidget {
  /// {@macro TempView.class}
  const TempView({super.key, required this.child});

  final Widget child;

  @override
  State<TempView> createState() => _TempViewState();
}

class _TempViewState extends State<TempView> {
  int _currentIndex = 0;

  void changeTab(int index) => setState(() => _currentIndex = index);

  void changeTheme() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text('Rick and Morty'),
        actions: [
          IconButton(onPressed: changeTheme, icon: const Icon(Icons.dark_mode)),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: changeTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
        ],
      ),
    );
  }
}
