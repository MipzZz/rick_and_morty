part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent {}

final class FavoritesEvent$Load extends FavoritesEvent {
  final List<FilterEnum> filters;

  FavoritesEvent$Load({required this.filters});
}
final class FavoritesEvent$SaveToFavorites extends FavoritesEvent {
  final CharacterCard characterCard;
  FavoritesEvent$SaveToFavorites(this.characterCard);

}
final class FavoritesEvent$RemoveFromFavorites extends FavoritesEvent {
  final CharacterCard characterCard;
  FavoritesEvent$RemoveFromFavorites(this.characterCard);

}
