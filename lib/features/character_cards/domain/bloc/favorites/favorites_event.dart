part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent {}

final class FavoritesEvent$Load extends FavoritesEvent {}
final class FavoritesEvent$SaveToFavorites extends FavoritesEvent {
  final CharacterCard characterCard;
  FavoritesEvent$SaveToFavorites(this.characterCard);
}
