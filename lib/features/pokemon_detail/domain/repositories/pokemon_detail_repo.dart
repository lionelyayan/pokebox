import 'package:dartz/dartz.dart';

import '../entities/evolution_entity.dart';
import '../entities/moves_item_entity.dart';
import '../entities/pokemon_detail_entity.dart';
import '../entities/species_entity.dart';

abstract class PokemonDetailRepo {
  Future<Either<String, PokemonDetailEntity>> pokemonDetailGET(int id);
  Future<Either<String, SpeciesEntity>> speciesGET(String url);
  Future<Either<String, List<EvolutionEntity>>> evolutionGET(String url);
  Future<Either<String, MovesItemEntity>> movesItemGET(String url);
}
