import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        // TODO(MipZ): Настроить цвет для границы карточки, в зависимости от мода
        border: Border.all(width: 4.0, color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              // TODO(MipZ): Добавить плейсхолдер при загрузке
              _CardNetworkImage(characterCard: characterCard),
              Positioned(
                right: 0,
                child: BlocSelector<FavoritesBloc, FavoritesState, bool>(
                  selector: (state) => state.isCharacterFavorite(characterCard.id),
                  builder: (context, isFavorite) {
                    return IconButton(
                      onPressed: () => _addToFavorites(context, isFavorite),
                      icon: isFavorite
                          ? const Icon(Icons.favorite, color: Colors.red)
                          : const Icon(Icons.favorite, color: Colors.white),
                    );
                  },
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 2)],
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            characterCard.status,
                            style:
                                Theme.of(context).textTheme.bodyMedium?.apply(fontWeightDelta: 3, color: Colors.white),
                          ),
                          // Text(
                          //   characterCard.gender,
                          //   style: Theme.of(context).textTheme.bodyMedium?.apply(fontWeightDelta: 2, color: Colors.white),
                          // ),
                          // Text(
                          //   characterCard.status,
                          //   style: Theme.of(context).textTheme.bodyMedium?.apply(fontWeightDelta: 2, color: Colors.white),
                          // ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                characterCard.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardNetworkImage extends StatelessWidget {
  const _CardNetworkImage({required this.characterCard});

  final CharacterCard characterCard;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        characterCard.image,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return SizedBox(
            width: _imageSize,
            height: _imageSize,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        width: _imageSize,
        height: _imageSize,
        fit: BoxFit.cover,
      ),
    );
  }
}
