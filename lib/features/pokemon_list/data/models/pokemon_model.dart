import 'package:pokebox/core/base/app_strings.dart';

import '../../domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.url,
    required super.imgUrl,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'] ?? '';
    final regex = RegExp(r'/pokemon/(\d+)/?$');
    final match = regex.firstMatch(url);
    final id = match != null ? match.group(1) ?? '' : '';

    return PokemonModel(
      id: id.isNotEmpty ? int.parse(id) : 0,
      name: json['name'] ?? '',
      url: url,
      imgUrl: id.isNotEmpty ? '${AppStrings().imgPokemon}$id.png' : '',
    );
  }

  static List<PokemonModel> fromJsonList(List jsonList) {
    return jsonList.isEmpty
        ? []
        : jsonList.map((json) => PokemonModel.fromJson(json)).toList();
  }
}
