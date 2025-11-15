import 'package:dartz/dartz.dart';

import '../entities/moves_item_entity.dart';
import '../repositories/pokemon_detail_repo.dart';

class MovesItemUsecase {
  final PokemonDetailRepo repo;

  MovesItemUsecase(this.repo);

  Future<Either<String, MovesItemEntity>> call(String url) async {
    return await repo.movesItemGET(url);
  }
}
