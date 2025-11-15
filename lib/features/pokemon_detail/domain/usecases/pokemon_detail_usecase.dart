import 'package:dartz/dartz.dart';

import '../entities/pokemon_detail_entity.dart';
import '../repositories/pokemon_detail_repo.dart';

class PokemonDetailUsecase {
  final PokemonDetailRepo repo;

  PokemonDetailUsecase(this.repo);

  Future<Either<String, PokemonDetailEntity>> call(int id) async {
    return await repo.pokemonDetailGET(id);
  }
}
