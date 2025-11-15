import 'package:pokebox/features/pokemon_list/data/models/pokemon_model.dart';

import '../../domain/entities/pokemon_list_entity.dart';

class PokemonListModel extends PokemonListEntity {
  const PokemonListModel({
    required super.count,
    required super.next,
    required super.previous,
    required super.results,
  });

  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel(
      count: json['count'] ?? 0,
      next: json['next'] ?? '',
      previous: json['previous'] ?? '',
      results: PokemonModel.fromJsonList(json['results'] ?? []),
    );
  }

  static List<PokemonListModel> fromJsonList(List jsonList) {
    return jsonList.isEmpty
        ? []
        : jsonList.map((json) => PokemonListModel.fromJson(json)).toList();
  }
}
