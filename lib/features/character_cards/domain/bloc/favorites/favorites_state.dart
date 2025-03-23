part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesState {
  final UnmodifiableListView<CharacterCard>? favoritesCharacters;

  const FavoritesState({this.favoritesCharacters});

  const factory FavoritesState.idle({required UnmodifiableListView<CharacterCard> favoritesCharacters}) =
      FavoritesState$Idle;

  const factory FavoritesState.processing({required UnmodifiableListView<CharacterCard> favoritesCharacters}) =
      FavoritesState$Processing;

  const factory FavoritesState.error({required UnmodifiableListView<CharacterCard> favoritesCharacters, required Object error}) =
      FavoritesState$Error;

  bool isCharacterFavorite(int id) {
    if (favoritesCharacters == null) return false;
    return favoritesCharacters!.any((element) => element.id == id);
  }
}

final class FavoritesState$Idle extends FavoritesState {
  const FavoritesState$Idle({super.favoritesCharacters});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoritesState$Idle && other.favoritesCharacters == favoritesCharacters;
  }

  @override
  int get hashCode => favoritesCharacters.hashCode;
}

final class FavoritesState$Processing extends FavoritesState {
  const FavoritesState$Processing({super.favoritesCharacters});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoritesState$Processing && other.favoritesCharacters == favoritesCharacters;
  }

  @override
  int get hashCode => favoritesCharacters.hashCode;
}

final class FavoritesState$Error extends FavoritesState {
  final Object error;

  const FavoritesState$Error({super.favoritesCharacters, required this.error});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoritesState$Error && other.favoritesCharacters == favoritesCharacters;
  }

  @override
  int get hashCode => favoritesCharacters.hashCode;
}
