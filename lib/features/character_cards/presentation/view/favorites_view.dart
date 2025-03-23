import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/favorites/favorites_bloc.dart';
import 'package:rick_and_morty/features/character_cards/presentation/view/cards_view.dart';

/// {@template FavoritesView.class}
/// FavoritesView widget.
/// {@endtemplate}
class FavoritesView extends StatelessWidget {
  /// {@macro FavoritesView.class}
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) => switch (state) {
        FavoritesState$Processing() => Center(child: CircularProgressIndicator()),
        FavoritesState$Error(:final error) => Center(child: Text(error.toString())),
        FavoritesState$Idle(:final favoritesCharacters) => ListView.builder(
            itemCount: favoritesCharacters?.length ?? 0,
            itemBuilder: (context, index) => CardTile(characterCard: favoritesCharacters![index]),
          ),
      },
    );
  }
}
