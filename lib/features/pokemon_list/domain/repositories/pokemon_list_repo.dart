import 'package:dartz/dartz.dart';

import '../entities/pokemon_list_entity.dart';

abstract class PokemonListRepo {
  Future<Either<String, PokemonListEntity>> pokemonListGET(
    int limit,
    int offset,
  );
}
