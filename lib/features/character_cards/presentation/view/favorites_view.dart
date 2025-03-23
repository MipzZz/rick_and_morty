import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/favorites/favorites_bloc.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/card_tile.dart';

/// {@template FavoritesView.class}
/// FavoritesView widget.
/// {@endtemplate}
class FavoritesView extends StatelessWidget {
  /// {@macro FavoritesView.class}
  const FavoritesView({super.key});

  Future<void> _loadFavorites(BuildContext context) async {
    final favoritesBloc = context.read<FavoritesBloc>()
    ..add(FavoritesEvent$Load());
    await favoritesBloc.stream.first;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _loadFavorites(context),
      child: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) => switch (state) {
          FavoritesState$Processing() => Center(child: CircularProgressIndicator()),
          FavoritesState$Error(:final error) => Center(child: Text(error.toString())),
          FavoritesState$Idle(:final favoritesCharacters) => ListView.builder(
              itemCount: favoritesCharacters?.length ?? 0,
              itemBuilder: (context, index) => CardTile(characterCard: favoritesCharacters![index]),
            ),
        },
      ),
    );
  }
}
