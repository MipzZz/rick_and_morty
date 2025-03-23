import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/favorites/favorites_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';

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
            // TODO(MipZ): Добавить плейсхолдер при загрузке
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
