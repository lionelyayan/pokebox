import 'package:get_it/get_it.dart';

import '../../features/pokemon_detail/data/datasources/pokemon_detail_datasource.dart';
import '../../features/pokemon_detail/data/repositories/pokemon_detail_repo_impl.dart';
import '../../features/pokemon_detail/domain/repositories/pokemon_detail_repo.dart';
import '../../features/pokemon_detail/domain/usecases/evolution_usecase.dart';
import '../../features/pokemon_detail/domain/usecases/moves_item_usecase.dart';
import '../../features/pokemon_detail/domain/usecases/pokemon_detail_usecase.dart';
import '../../features/pokemon_detail/domain/usecases/species_usecase.dart';
import '../../features/pokemon_list/data/datasources/pokemon_list_datasource.dart';
import '../../features/pokemon_list/data/repositories/pokemon_list_repo_impl.dart';
import '../../features/pokemon_list/domain/repositories/pokemon_list_repo.dart';
import '../../features/pokemon_list/domain/usecases/pokemon_list_usecase.dart';
import '../../features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';

final injection = GetIt.I;

Future<void> getInit() async {
  injection.registerFactory(
    () => PokemonListBloc(
      pokemonListUsecase: injection(),
      pokemonDetailUsecase: injection(),
      speciesUsecase: injection(),
      evolutionUsecase: injection(),
      movesItemUsecase: injection(),
    ),
  );

  injection.registerLazySingleton(() => PokemonListUsecase(injection()));
  injection.registerLazySingleton(() => PokemonDetailUsecase(injection()));
  injection.registerLazySingleton(() => SpeciesUsecase(injection()));
  injection.registerLazySingleton(() => EvolutionUsecase(injection()));
  injection.registerLazySingleton(() => MovesItemUsecase(injection()));

  injection.registerLazySingleton<PokemonListRepo>(
    () => PokemonListRepoImpl(datasource: injection()),
  );
  injection.registerLazySingleton<PokemonDetailRepo>(
    () => PokemonDetailRepoImpl(datasource: injection()),
  );

  injection.registerLazySingleton<PokemonListDatasource>(
    () => PokemonListDatasourceImpl(),
  );
  injection.registerLazySingleton<PokemonDetailDatasource>(
    () => PokemonDetailDatasourceImpl(),
  );
}
