import 'package:dio/dio.dart';

import '../../../../core/api/dio/dio_request.dart';
import '../../../../core/api/dio/dio_response.dart';
import '../../../../core/base/app_strings.dart';
import '../models/pokemon_list_model.dart';

abstract class PokemonListDatasource {
  Future<PokemonListModel> pokemonListGET(int limit, int offset);
}

class PokemonListDatasourceImpl implements PokemonListDatasource {
  late final DioRequest dioRequest;
  Dio? dioMock;

  PokemonListDatasourceImpl({this.dioMock}) {
    dioRequest = DioRequest(dioMock: dioMock);
  }

  @override
  Future<PokemonListModel> pokemonListGET(int limit, int offset) async {
    Map<String, dynamic> params = {"limit": limit, "offset": offset};

    Dioresponse response = await dioRequest.requestGET(
      AppStrings().baseUrl,
      params,
    );

    if (response.error) {
      throw response.message;
    }

    return PokemonListModel.fromJson(response.data);
  }
}
