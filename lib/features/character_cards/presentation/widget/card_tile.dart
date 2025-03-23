import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/assets/images.dart';
import 'package:rick_and_morty/features/character_cards/domain/bloc/favorites/favorites_bloc.dart';
import 'package:rick_and_morty/features/character_cards/domain/model/character_card.dart';

const double _imageSize = 250.0;

/// {@template CardTile.class}
/// CardTile widget.
/// {@endtemplate}
class CardTile extends StatelessWidget {
  /// {@macro CardTile.class}
  const CardTile({super.key, required this.characterCard});

  final CharacterCard characterCard;

  void _addToFavorites(BuildContext context, bool isFavorite) {
    if (isFavorite) return context.read<FavoritesBloc>().add(FavoritesEvent$RemoveFromFavorites(characterCard));
    context.read<FavoritesBloc>().add(FavoritesEvent$SaveToFavorites(characterCard));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              // TODO(MipZ): Добавить плейсхолдер при загрузке
              Image.network(
                characterCard.image,
                width: _imageSize,
                height: _imageSize,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 0,
                child: BlocSelector<FavoritesBloc, FavoritesState, bool>(
                  selector: (state) => state.isCharacterFavorite(characterCard.id),
                  builder: (context, isFavorite) {
                    return IconButton(
                      onPressed: () => _addToFavorites(context, isFavorite),
                      icon: isFavorite ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite, color: Colors.white,),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(Images.cardBackground), fit: BoxFit.fill),
              ),
              child: Center(
                child: Text(
                  characterCard.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
