import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../pokemon_detail/domain/entities/evolution_entity.dart';
import '../../../pokemon_detail/domain/entities/moves_item_entity.dart';
import '../../../pokemon_detail/domain/entities/pokemon_detail_entity.dart';
import '../../../pokemon_detail/domain/entities/species_entity.dart';
import '../../../pokemon_detail/domain/usecases/evolution_usecase.dart';
import '../../../pokemon_detail/domain/usecases/moves_item_usecase.dart';
import '../../../pokemon_detail/domain/usecases/pokemon_detail_usecase.dart';
import '../../../pokemon_detail/domain/usecases/species_usecase.dart';
import '../../domain/entities/pokemon_list_entity.dart';
import '../../domain/usecases/pokemon_list_usecase.dart';

part 'pokemon_list_event.dart';
part 'pokemon_list_state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final PokemonListUsecase pokemonListUsecase;
  final PokemonDetailUsecase pokemonDetailUsecase;
  final SpeciesUsecase speciesUsecase;
  final EvolutionUsecase evolutionUsecase;
  final MovesItemUsecase movesItemUsecase;

  PokemonListBloc({
    required this.pokemonListUsecase,
    required this.pokemonDetailUsecase,
    required this.speciesUsecase,
    required this.evolutionUsecase,
    required this.movesItemUsecase,
  }) : super(PokemonListInitial()) {
    on<GetListPokemonEvent>((event, emit) async {
      emit(GetListPokemonStateLoading());

      Either<String, PokemonListEntity> result = await pokemonListUsecase.call(
        event.limit,
        event.offset,
      );
      result.fold(
        (l) => emit(GetListPokemonStateError(l)),
        (r) => emit(GetListPokemonStateLoaded(r)),
      );
    });

    on<GetDetailPokemonEvent>((event, emit) async {
      emit(GetDetailPokemonStateLoading());

      Either<String, PokemonDetailEntity> result = await pokemonDetailUsecase
          .call(event.id);
      result.fold(
        (l) => emit(GetDetailPokemonStateError(l)),
        (r) => emit(GetDetailPokemonStateLoaded(r)),
      );
    });

    on<GetSpeciesEvent>((event, emit) async {
      emit(GetSpeciesStateLoading());

      Either<String, SpeciesEntity> result = await speciesUsecase.call(
        event.url,
      );
      result.fold(
        (l) => emit(GetSpeciesStateError(l)),
        (r) => emit(GetSpeciesStateLoaded(r)),
      );
    });

    on<GetEvolutionEvent>((event, emit) async {
      emit(GetEvolutionStateLoading());

      Either<String, List<EvolutionEntity>> result = await evolutionUsecase
          .call(event.url);
      result.fold(
        (l) => emit(GetEvolutionStateError(l)),
        (r) => emit(GetEvolutionStateLoaded(r)),
      );
    });

    on<GetMovesItemEvent>((event, emit) async {
      emit(GetMovesItemStateLoading());

      Either<String, MovesItemEntity> result = await movesItemUsecase.call(
        event.url,
      );
      result.fold(
        (l) => emit(GetMovesItemStateError(l)),
        (r) => emit(GetMovesItemStateLoaded(r)),
      );
    });
  }
}
