import 'package:dartz/dartz.dart';

import '../../domain/entities/evolution_entity.dart';
import '../../domain/entities/moves_item_entity.dart';
import '../../domain/entities/pokemon_detail_entity.dart';
import '../../domain/entities/species_entity.dart';
import '../../domain/repositories/pokemon_detail_repo.dart';
import '../datasources/pokemon_detail_datasource.dart';

class PokemonDetailRepoImpl extends PokemonDetailRepo {
  final PokemonDetailDatasource datasource;

  PokemonDetailRepoImpl({required this.datasource});

  @override
  Future<Either<String, PokemonDetailEntity>> pokemonDetailGET(int id) async {
    try {
      final result = await datasource.pokemonDetailGET(id);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, SpeciesEntity>> speciesGET(String url) async {
    try {
      final result = await datasource.speciesGET(url);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<EvolutionEntity>>> evolutionGET(String url) async {
    try {
      final result = await datasource.evolutionGET(url);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MovesItemEntity>> movesItemGET(String url) async {
    try {
      final result = await datasource.movesItemGET(url);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
