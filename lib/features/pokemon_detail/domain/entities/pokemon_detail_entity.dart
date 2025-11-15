import 'package:equatable/equatable.dart';

import 'cries_entity.dart';
import 'moves_entity.dart';

class PokemonDetailEntity extends Equatable {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final List<String> abilities;
  final List<Map<String, dynamic>> stats;
  final List<MovesEntity> moves;
  final String urlSpecies;
  final int baseExperience;
  final CriesEntity cries;

  const PokemonDetailEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.stats,
    required this.moves,
    required this.urlSpecies,
    required this.baseExperience,
    required this.cries,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    height,
    weight,
    types,
    abilities,
    stats,
    moves,
    urlSpecies,
    baseExperience,
    cries,
  ];
}
