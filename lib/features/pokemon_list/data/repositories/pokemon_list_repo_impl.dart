import 'package:dartz/dartz.dart';

import '../../domain/entities/pokemon_list_entity.dart';
import '../../domain/repositories/pokemon_list_repo.dart';
import '../datasources/pokemon_list_datasource.dart';

class PokemonListRepoImpl extends PokemonListRepo {
  final PokemonListDatasource datasource;

  PokemonListRepoImpl({required this.datasource});

  @override
  Future<Either<String, PokemonListEntity>> pokemonListGET(
    int limit,
    int offset,
  ) async {
    try {
      final result = await datasource.pokemonListGET(limit, offset);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
