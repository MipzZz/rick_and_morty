import 'package:flutter/foundation.dart' show immutable;

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

  factory CharacterCard.fromJson(Map<String, dynamic> json) {
    return CharacterCard(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
    );
  }

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
