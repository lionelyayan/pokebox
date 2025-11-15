import 'package:dartz/dartz.dart';

import '../entities/pokemon_list_entity.dart';
import '../repositories/pokemon_list_repo.dart';

class PokemonListUsecase {
  final PokemonListRepo repo;

  PokemonListUsecase(this.repo);

  Future<Either<String, PokemonListEntity>> call(int limit, int offset) async {
    return await repo.pokemonListGET(limit, offset);
  }
}
