import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/character_cards/character_cards_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/favorites/favorites_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';

/// {@template CardsView.class}
/// CardsView widget.
/// {@endtemplate}
class CardsView extends StatelessWidget {
  /// {@macro CardsView.class}
  const CardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<CharacterCardsBloc, CharacterCardsState>(
        builder: (context, state) => switch (state) {
          CharacterCards$Processing() => Center(child: CircularProgressIndicator()),
          CharacterCards$Error(:final error) => Center(child: Text(error.toString())),
          CharacterCards$Idle(:final characterCards) => ListView.builder(
              itemCount: characterCards?.length ?? 0,
              itemBuilder: (context, index) => CardTile(characterCard: characterCards![index]),
            ),
        },
      ),
    );
  }
}

/// {@template CardTile.class}
/// CardTile widget.
/// {@endtemplate}
class CardTile extends StatelessWidget {
  /// {@macro CardTile.class}
  const CardTile({super.key, required this.characterCard});

  final CharacterCard characterCard;

  void _addToFavorites(BuildContext context) {
    context.read<FavoritesBloc>().add(FavoritesEvent$SaveToFavorites(characterCard));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.network(characterCard.image),
            Positioned(right: 0, child: IconButton(onPressed: () =>  _addToFavorites(context), icon: Icon(Icons.favorite))),
          ],
        ),
        Text(characterCard.name),
        Text(characterCard.gender),
        Text(characterCard.type),
      ],
    );
  }
}
