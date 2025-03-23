import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/character_cards/presentation/view/cards_view.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/temp_view.dart';
import 'package:rick_and_morty/features/character_cards/presentation/view/favorites_view.dart';
import 'package:rick_and_morty/features/navigation/presentation/view/not_found_view.dart';
import 'package:rick_and_morty/features/navigation/utils/app_route_paths.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutePaths.home:
      return MaterialPageRoute(
        builder: (_) => TempView(),
      );
    case AppRoutePaths.cards:
      return MaterialPageRoute(builder: (_) => CardsView());
    case AppRoutePaths.favorites:
      return MaterialPageRoute(builder: (_) => FavoritesView());
    default:
      return MaterialPageRoute(builder: (_) => NotFoundView());
  }
}
