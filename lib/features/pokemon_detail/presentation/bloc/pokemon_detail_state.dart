part of 'pokemon_detail_bloc.dart';

abstract class PokemonDetailState extends Equatable {
  const PokemonDetailState();  

  @override
  List<Object> get props => [];
}
class PokemonDetailInitial extends PokemonDetailState {}
