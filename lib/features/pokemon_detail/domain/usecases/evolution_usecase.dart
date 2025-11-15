import 'package:dartz/dartz.dart';

import '../entities/evolution_entity.dart';
import '../repositories/pokemon_detail_repo.dart';

class EvolutionUsecase {
  final PokemonDetailRepo repo;

  EvolutionUsecase(this.repo);

  Future<Either<String, List<EvolutionEntity>>> call(String url) async {
    return await repo.evolutionGET(url);
  }
}
