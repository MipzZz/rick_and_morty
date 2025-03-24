import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/character_cards/character_cards_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/filters_bloc/filters_bloc.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/cards_grid.dart';

/// {@template CardsView.class}
/// CardsView widget.
/// {@endtemplate}
class CardsView extends StatelessWidget {
  /// {@macro CardsView.class}
  const CardsView({super.key});

  Future<void> _loadCards(BuildContext context) async {
    final filters = context.read<FiltersBloc>().state.filters;
    final characterCardsBloc = context.read<CharacterCardsBloc>()..add(CharacterCardsEvent$Load(filters: filters));
    await characterCardsBloc.stream.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FiltersBloc(),
      child: RefreshIndicator(
        onRefresh: () => _loadCards(context),
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BlocBuilder<CharacterCardsBloc, CharacterCardsState>(
            builder: (context, state) => switch (state) {
              CharacterCards$Processing() => Center(child: CircularProgressIndicator()),
              CharacterCards$Error(:final error) => Center(child: Text(error.toString())),
              CharacterCards$Idle(:final characterCards) => BlocBuilder<FiltersBloc, FiltersState>(
                  builder: (context, filtersState) {
                    return CardsGrid(
                      filters: filtersState.filters,
                      characterCards: characterCards,
                    );
                  },
                ),
            },
          ),
        ),
      ),
    );
  }
}
