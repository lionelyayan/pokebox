import '../../domain/entities/evolution_entity.dart';

class EvolutionModel extends EvolutionEntity {
  const EvolutionModel({required super.name, required super.imgUrl});

  static List<EvolutionModel> parseEvolutionChain(Map<String, dynamic> json) {
    List<EvolutionModel> evolutions = [];

    void extractEvolution(Map<String, dynamic> node) {
      final species = node["species"];
      evolutions.add(
        EvolutionModel(name: species["name"], imgUrl: species["url"]),
      );

      final evolvesTo = node["evolves_to"] as List;
      if (evolvesTo.isNotEmpty) {
        extractEvolution(evolvesTo[0]);
      }
    }

    extractEvolution(json["chain"]);
    return evolutions;
  }
}
