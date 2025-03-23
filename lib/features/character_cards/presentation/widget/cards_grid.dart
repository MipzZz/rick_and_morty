import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';
import 'package:rick_and_morty/features/character_cards/presentation/widget/card_tile.dart';

/// {@template CardsGrid.class}
/// CardsGrid widget.
/// {@endtemplate}
class CardsGrid extends StatelessWidget {
  /// {@macro CardsGrid.class}
  const CardsGrid({super.key, required this.characterCards});

  final UnmodifiableListView<CharacterCard>? characterCards;

  static const _fallbackHeight = 160.0;
  static const _fallbackWidth = 270.0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        PinnedHeaderSliver(
          child: ColoredBox(color: Colors.white, child: Text('filters')),
        ),
        SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: _fallbackHeight / _fallbackWidth),
          itemCount: characterCards?.length ?? 0,
          itemBuilder: (context, index) => CardTile(characterCard: characterCards![index]),
        ),
      ],
    );
  }
}
