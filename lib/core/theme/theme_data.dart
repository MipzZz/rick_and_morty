import 'package:flutter/material.dart';

abstract class AppThemeData {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.orange,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.deepOrange,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
  );

  static final _pageTransitionsTheme = const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
  });
}
