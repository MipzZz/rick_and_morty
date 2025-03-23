import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/favorites/favorites_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/card_tile.dart';

/// {@template FavoritesView.class}
/// FavoritesView widget.
/// {@endtemplate}
class FavoritesView extends StatelessWidget {
  /// {@macro FavoritesView.class}
  const FavoritesView({super.key});

  Future<void> _loadFavorites(BuildContext context) async {
    final favoritesBloc = context.read<FavoritesBloc>()..add(FavoritesEvent$Load());
    await favoritesBloc.stream.first;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _loadFavorites(context),
      child: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) => switch (state) {
            FavoritesState$Processing() => Center(child: CircularProgressIndicator()),
            FavoritesState$Error(:final error) => Center(child: Text(error.toString())),
            FavoritesState$Idle(:final favoritesCharacters) => _FavoriteList(favoritesCharacters: favoritesCharacters),
          },
        ),
      ),
    );
  }
}

class _FavoriteList extends StatefulWidget {
  const _FavoriteList({required this.favoritesCharacters});

  final UnmodifiableListView<CharacterCard>? favoritesCharacters;

  @override
  State<_FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<_FavoriteList> {
  late final List<CharacterCard> _favoriteItems;

  @override
  void initState() {
    super.initState();
    _favoriteItems = List.from(widget.favoritesCharacters ?? []);
  }

  @override
  void didUpdateWidget(covariant _FavoriteList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.favoritesCharacters != oldWidget.favoritesCharacters) {
      _favoriteItems = List.from(widget.favoritesCharacters ?? []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.favoritesCharacters?.length ?? 0,
      itemBuilder: (context, index) {
        return AnimatedSlide(
          offset: widget.favoritesCharacters!.contains(_favoriteItems[index]) ? Offset.zero : const Offset(1, 0),
          duration: Duration(seconds: 1000),
          child: CardTile(characterCard: _favoriteItems[index]),
        );
      },
    );
  }
}
