part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesState {
  final UnmodifiableListView<CharacterCard>? _favoritesCharacters;

  const FavoritesState(this._favoritesCharacters);

  UnmodifiableListView<CharacterCard>? get favoritesCharacters => _favoritesCharacters;
}

final class FavoritesState$Idle extends FavoritesState {
  const FavoritesState$Idle(super.favoritesCharacters);
}

final class FavoritesState$Processing extends FavoritesState {
  const FavoritesState$Processing(super.favoritesCharacters);
}

final class FavoritesState$Error extends FavoritesState {
  final Object error;

  const FavoritesState$Error(super.favoritesCharacters, {required this.error});
}
