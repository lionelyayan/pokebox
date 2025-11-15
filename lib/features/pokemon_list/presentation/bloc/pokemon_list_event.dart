part of 'pokemon_list_bloc.dart';

abstract class PokemonListEvent extends Equatable {}

class GetListPokemonEvent extends PokemonListEvent {
  final int limit;
  final int offset;

  GetListPokemonEvent(this.limit, this.offset);

  @override
  List<Object?> get props => [limit, offset];
}

class GetDetailPokemonEvent extends PokemonListEvent {
  final int id;

  GetDetailPokemonEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetSpeciesEvent extends PokemonListEvent {
  final String url;

  GetSpeciesEvent(this.url);

  @override
  List<Object?> get props => [url];
}

class GetEvolutionEvent extends PokemonListEvent {
  final String url;

  GetEvolutionEvent(this.url);

  @override
  List<Object?> get props => [url];
}

class GetMovesItemEvent extends PokemonListEvent {
  final String url;

  GetMovesItemEvent(this.url);

  @override
  List<Object?> get props => [url];
}
