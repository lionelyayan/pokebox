import '../../domain/entities/moves_item_entity.dart';

class MovesItemModel extends MovesItemEntity {
  const MovesItemModel({
    required super.power,
    required super.accuracy,
    required super.pp,
  });

  factory MovesItemModel.fromJson(Map<String, dynamic> json) {
    return MovesItemModel(
      power: json['power'] ?? 0,
      accuracy: json['accuracy'] ?? 0,
      pp: json['pp'] ?? 0,
    );
  }
}
