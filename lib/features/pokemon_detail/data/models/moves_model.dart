import '../../domain/entities/moves_entity.dart';

class MovesModel extends MovesEntity {
  const MovesModel({required super.name, required super.url});

  factory MovesModel.fromJson(Map<String, dynamic> json) {
    return MovesModel(name: json['move']['name'], url: json['move']['url']);
  }

  static List<MovesModel> fromJsonList(List list) {
    return list.map((e) => MovesModel.fromJson(e)).toList();
  }
}
