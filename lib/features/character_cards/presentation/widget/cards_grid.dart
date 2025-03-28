import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/filters_enum.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/card_tile.dart';

const double _fallbackWidth = 160.0;
const double _fallbackHeight = 270.0;

/// {@template CardsGrid.class}
/// CardsGrid widget.
/// {@endtemplate}
class SliverCardsGrid extends StatefulWidget {
  /// {@macro CardsGrid.class}
  const SliverCardsGrid(
      {super.key, required this.characterCards, required this.filters, required this.isLoadingMoreData});

  final UnmodifiableListView<CharacterCard>? characterCards;
  final List<FilterEnum> filters;
  final bool isLoadingMoreData;

  @override
  State<SliverCardsGrid> createState() => _SliverCardsGridState();
}

class _SliverCardsGridState extends State<SliverCardsGrid> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: _fallbackWidth / _fallbackHeight,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: widget.characterCards?.length ?? 0,
          itemBuilder: (context, index) => CardTile(characterCard: widget.characterCards![index]),
        ),
        if (widget.isLoadingMoreData)
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          ))
      ],
    );
  }
}
