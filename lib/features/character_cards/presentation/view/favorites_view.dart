import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/favorites/favorites_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/filters_bloc/filters_bloc.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/cards_grid.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/filters_panel.dart';

/// {@template FavoritesView.class}
/// FavoritesView widget.
/// {@endtemplate}
class FavoritesView extends StatelessWidget {
  /// {@macro FavoritesView.class}
  const FavoritesView({super.key});

  Future<void> _loadFavorites(BuildContext context) async {
    final filters = context.read<FiltersBloc>().state.filters;
    final favoritesBloc = context.read<FavoritesBloc>()..add(FavoritesEvent$Load(filters: filters));
    await favoritesBloc.stream.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FiltersBloc(),
      child: Builder(
        builder: (context) {
          return RefreshIndicator(
            onRefresh: () => _loadFavorites(context),
            child: ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    FiltersPanel(),
                    Expanded(
                      child: BlocBuilder<FavoritesBloc, FavoritesState>(
                        builder: (context, state) => switch (state) {
                          FavoritesState$Processing() => Center(child: CircularProgressIndicator()),
                          FavoritesState$Error(:final error) => Center(child: Text(error.toString())),
                          FavoritesState$Idle(:final favoritesCharacters) => BlocConsumer<FiltersBloc, FiltersState>(
                              listener: (_,__) => _loadFavorites(context),
                              builder: (context, filtersState) {
                                return SliverCardsGrid(
                                  filters: filtersState.filters,
                                  isLoadingMoreData: false,
                                  characterCards: favoritesCharacters,
                                );
                              },
                            ),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
