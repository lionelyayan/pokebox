import '../../domain/entities/pokemon_detail_entity.dart';
import 'cries_model.dart';
import 'moves_model.dart';

class PokemonDetailModel extends PokemonDetailEntity {
  const PokemonDetailModel({
    required super.id,
    required super.name,
    required super.height,
    required super.weight,
    required super.types,
    required super.abilities,
    required super.stats,
    required super.moves,
    required super.urlSpecies,
    required super.baseExperience,
    required super.cries,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailModel(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      types:
          (json['types'] as List?)
              ?.map((t) => t['type']['name'] as String)
              .toList() ??
          [],
      abilities:
          (json['abilities'] as List?)
              ?.map((t) => t['ability']['name'] as String)
              .toList() ??
          [],
      stats: (json['stats'] as List)
          .map((s) => {'name': s['stat']['name'], 'value': s['base_stat']})
          .toList(),
      moves: MovesModel.fromJsonList(json['moves'] ?? []),
      urlSpecies: json['species']['url'] ?? '',
      baseExperience: json['base_experience'],
      cries: CriesModel.fromJson(json),
    );
  }
}
