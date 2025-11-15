import '../../domain/entities/cries_entity.dart';

class CriesModel extends CriesEntity {
  const CriesModel({required super.latest, required super.legacy});

  factory CriesModel.fromJson(Map<String, dynamic> json) {
    return CriesModel(
      latest: json['cries']['latest'] ?? '',
      legacy: json['cries']['legacy'] ?? '',
    );
  }
}
