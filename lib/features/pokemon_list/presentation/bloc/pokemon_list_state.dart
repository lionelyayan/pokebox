part of 'pokemon_list_bloc.dart';

abstract class PokemonListState extends Equatable {}

class PokemonListInitial extends PokemonListState {
  @override
  List<Object?> get props => [];
}

class GetListPokemonStateLoading extends PokemonListState {
  @override
  List<Object?> get props => [];
}

class GetListPokemonStateError extends PokemonListState {
  final String message;

  GetListPokemonStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetListPokemonStateLoaded extends PokemonListState {
  final PokemonListEntity pokemonListEntity;

  GetListPokemonStateLoaded(this.pokemonListEntity);

  @override
  List<Object?> get props => [pokemonListEntity];
}

class GetDetailPokemonStateLoading extends PokemonListState {
  @override
  List<Object?> get props => [];
}

class GetDetailPokemonStateError extends PokemonListState {
  final String message;

  GetDetailPokemonStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetDetailPokemonStateLoaded extends PokemonListState {
  final PokemonDetailEntity pokemonDetailEntity;

  GetDetailPokemonStateLoaded(this.pokemonDetailEntity);

  @override
  List<Object?> get props => [pokemonDetailEntity];
}

class GetSpeciesStateLoading extends PokemonListState {
  @override
  List<Object?> get props => [];
}

class GetSpeciesStateError extends PokemonListState {
  final String message;

  GetSpeciesStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetSpeciesStateLoaded extends PokemonListState {
  final SpeciesEntity speciesEntity;

  GetSpeciesStateLoaded(this.speciesEntity);

  @override
  List<Object?> get props => [speciesEntity];
}

class GetEvolutionStateLoading extends PokemonListState {
  @override
  List<Object?> get props => [];
}

class GetEvolutionStateError extends PokemonListState {
  final String message;

  GetEvolutionStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetEvolutionStateLoaded extends PokemonListState {
  final List<EvolutionEntity> evolutionEntity;

  GetEvolutionStateLoaded(this.evolutionEntity);

  @override
  List<Object?> get props => [evolutionEntity];
}


class GetMovesItemStateLoading extends PokemonListState {
  @override
  List<Object?> get props => [];
}

class GetMovesItemStateError extends PokemonListState {
  final String message;

  GetMovesItemStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetMovesItemStateLoaded extends PokemonListState {
  final MovesItemEntity movesItemEntity;

  GetMovesItemStateLoaded(this.movesItemEntity);

  @override
  List<Object?> get props => [movesItemEntity];
}