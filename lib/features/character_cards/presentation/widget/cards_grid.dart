import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/card_tile.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/filters_panel.dart';

/// {@template CardsGrid.class}
/// CardsGrid widget.
/// {@endtemplate}
class CardsGrid extends StatelessWidget {
  /// {@macro CardsGrid.class}
  const CardsGrid({super.key, required this.characterCards});

  final UnmodifiableListView<CharacterCard>? characterCards;

  static const _fallbackWidth = 160.0;
  static const _fallbackHeight = 270.0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        PinnedHeaderSliver(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ColoredBox(color: Theme.of(context).scaffoldBackgroundColor, child: FiltersPanel()),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: _fallbackWidth / _fallbackHeight,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: characterCards?.length ?? 0,
            itemBuilder: (context, index) => CardTile(characterCard: characterCards![index]),
          ),
        ),
      ],
    );
  }
}
