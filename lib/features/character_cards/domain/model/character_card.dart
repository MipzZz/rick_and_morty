import 'package:flutter/foundation.dart' show immutable;
import 'package:rick_and_morty/core/drift/database/app_drift_database.dart';
import 'package:rick_and_morty/core/utils/typdef.dart';

@immutable
class CharacterCard {
  final int id;
  final String name;
  final String status;
  final String type;
  final String gender;
  final String image;

  const CharacterCard({
    required this.id,
    required this.name,
    required this.status,
    required this.type,
    required this.gender,
    required this.image,
  });

  factory CharacterCard.fromFavorites(Favorite favorite) {
    return CharacterCard(
        id: favorite.id,
        name: favorite.name,
        status: favorite.status,
        type: favorite.type,
        gender: favorite.gender,
        image: favorite.image);
  }

  Favorite toFavorites() => Favorite(id: id, name: name, status: status, type: type, gender: gender, image: image);

  factory CharacterCard.fromCachedCard(CachedCard favorite) {
    return CharacterCard(
        id: favorite.id,
        name: favorite.name,
        status: favorite.status,
        type: favorite.type,
        gender: favorite.gender,
        image: favorite.image);
  }

  CachedCard toCached() => CachedCard(id: id, name: name, status: status, type: type, gender: gender, image: image);

  factory CharacterCard.fromJson(JsonMap json) {
    return CharacterCard(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
    );
  }

  JsonMap toJson() =>
      <String, dynamic>{'id': id, 'name': name, 'status': status, 'type': type, 'gender': gender, 'image': image};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterCard &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          status == other.status &&
          type == other.type &&
          gender == other.gender &&
          image == other.image;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ status.hashCode ^ type.hashCode ^ gender.hashCode ^ image.hashCode;
}

class PaginationCharacterCard {
  final Iterable<CharacterCard> characterCards;
  final int offset;
  PaginationCharacterCard({required this.characterCards, required this.offset});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginationCharacterCard &&
          runtimeType == other.runtimeType &&
          characterCards == other.characterCards &&
          offset == other.offset;

  @override
  int get hashCode => characterCards.hashCode ^ offset.hashCode;
}
