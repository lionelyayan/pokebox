import 'package:dartz/dartz.dart';

import '../entities/species_entity.dart';
import '../repositories/pokemon_detail_repo.dart';

class SpeciesUsecase {
  final PokemonDetailRepo repo;

  SpeciesUsecase(this.repo);

  Future<Either<String, SpeciesEntity>> call(String url) async {
    return await repo.speciesGET(url);
  }
}
