import '../../domain/entities/species_entity.dart';

class SpeciesModel extends SpeciesEntity {
  const SpeciesModel({required super.url});

  factory SpeciesModel.fromJson(Map<String, dynamic> json) {
    return SpeciesModel(url: json['evolution_chain']['url'] ?? '');
  }
}
