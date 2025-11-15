import 'package:dio/dio.dart';

import '../../../../core/api/dio/dio_request.dart';
import '../../../../core/api/dio/dio_response.dart';
import '../../../../core/base/app_strings.dart';
import '../models/evolution_model.dart';
import '../models/moves_item_model.dart';
import '../models/pokemon_detail_model.dart';
import '../models/species_model.dart';

abstract class PokemonDetailDatasource {
  Future<PokemonDetailModel> pokemonDetailGET(int id);
  Future<SpeciesModel> speciesGET(String url);
  Future<List<EvolutionModel>> evolutionGET(String url);
  Future<MovesItemModel> movesItemGET(String url);
}

class PokemonDetailDatasourceImpl extends PokemonDetailDatasource {
  late final DioRequest dioRequest;
  Dio? dioMock;

  PokemonDetailDatasourceImpl({this.dioMock}) {
    dioRequest = DioRequest(dioMock: dioMock);
  }

  @override
  Future<PokemonDetailModel> pokemonDetailGET(int id) async {
    Map<String, dynamic> params = {};

    Dioresponse response = await dioRequest.requestGET(
      '${AppStrings().baseUrl}$id',
      params,
    );

    if (response.error) {
      throw response.message;
    }

    return PokemonDetailModel.fromJson(response.data);
  }

  @override
  Future<SpeciesModel> speciesGET(String url) async {
    Map<String, dynamic> params = {};

    Dioresponse response = await dioRequest.requestGET(url, params);

    if (response.error) {
      throw response.message;
    }

    return SpeciesModel.fromJson(response.data);
  }

  @override
  Future<List<EvolutionModel>> evolutionGET(String url) async {
    Map<String, dynamic> params = {};

    Dioresponse response = await dioRequest.requestGET(url, params);

    if (response.error) {
      throw response.message;
    }

    return EvolutionModel.parseEvolutionChain(response.data);
  }

  @override
  Future<MovesItemModel> movesItemGET(String url) async {
    Map<String, dynamic> params = {};

    Dioresponse response = await dioRequest.requestGET(url, params);

    if (response.error) {
      throw response.message;
    }

    return MovesItemModel.fromJson(response.data);
  }
}
