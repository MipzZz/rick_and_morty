import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/character_cards/character_cards_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/filters_bloc/filters_bloc.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/cards_grid.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/filters_panel.dart';

/// {@template CardsView.class}
/// CardsView widget.
/// {@endtemplate}
class CardsView extends StatelessWidget {
  /// {@macro CardsView.class}
  const CardsView({super.key});

  Future<void> _loadCards(BuildContext context, [bool isFilterChanges = false]) async {

    final filters = context.read<FiltersBloc>().state.filters;
    final characterCardsBloc = context.read<CharacterCardsBloc>();
    if (characterCardsBloc.state.offset == null && !isFilterChanges) return;
    characterCardsBloc.add(CharacterCardsEvent$Load(offset: isFilterChanges ? 1 : characterCardsBloc.state.offset, filters: filters));
    await characterCardsBloc.stream.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FiltersBloc(),
      child: Builder(builder: (context) {
        return RefreshIndicator(
          onRefresh: () => _loadCards(context),
          child: ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  FiltersPanel(),
                  Expanded(
                    child: BlocBuilder<CharacterCardsBloc, CharacterCardsState>(
                      builder: (context, state) => switch (state) {
                        CharacterCards$Processing(:final characterCards) when (characterCards?.isEmpty ?? true) =>
                          Center(child: CircularProgressIndicator()),
                        CharacterCards$Error(:final error) => Center(child: Text(error.toString())),
                        _ => BlocConsumer<FiltersBloc, FiltersState>(
                            listener: (_, __) => _loadCards(context, true),
                            builder: (context, filtersState) {
                              return NotificationListener<ScrollNotification>(
                                onNotification: (notification) {
                                  if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
                                    _loadCards(context);
                                  }
                                  return false;
                                },
                                child: SliverCardsGrid(
                                  filters: filtersState.filters,
                                  isLoadingMoreData: state.offset != null,
                                  characterCards: state.characterCards,
                                ),
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
      }),
    );
  }
}
