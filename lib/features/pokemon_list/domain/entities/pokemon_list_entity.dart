import 'package:equatable/equatable.dart';

import 'pokemon_entity.dart';

class PokemonListEntity extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonEntity> results;

  const PokemonListEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  @override
  List<Object?> get props => [count, next, previous, results];
}
