import 'package:flutter/foundation.dart';
import 'package:pokebox/features/pokemon_detail/data/datasources/pokemon_detail_datasource.dart';
import 'package:pokebox/features/pokemon_list/data/datasources/pokemon_list_datasource.dart';

void main() async {
  // int limit = 20;
  // int offset = 0;
  // final PokemonListDatasourceImpl datasource = PokemonListDatasourceImpl();
  // var result = await datasource.pokemonListGET(limit, offset);

  // String url = 'https://pokeapi.co/api/v2/pokemon-species/1/';
  String url = 'https://pokeapi.co/api/v2/evolution-chain/1/';
  // String url = 'https://pokeapi.co/api/v2/move/13/';
  // int id = 1;
  final PokemonDetailDatasourceImpl datasource = PokemonDetailDatasourceImpl();
  // var result = await datasource.pokemonDetailGET(id);
  // var result = await datasource.speciesGET(url);
  var result = await datasource.evolutionGET(url);
  // var result = await datasource.movesItemGET(url);

  if (kDebugMode) {
    print('\n===================== TESTING DATA SOURCE =====================');
    print(result);
    print('===================== TESTING DATA SOURCE =====================');
  }
}
