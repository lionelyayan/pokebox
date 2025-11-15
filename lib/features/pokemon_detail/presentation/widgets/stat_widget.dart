import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import '../../domain/entities/pokemon_detail_entity.dart';

class StatWidget extends StatelessWidget {
  const StatWidget({super.key, required this.pokemonDetailEntity});

  final PokemonDetailEntity? pokemonDetailEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, left: 25, right: 25),
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 15),
        itemCount: pokemonDetailEntity?.stats.length ?? 0,
        itemBuilder: (context, index) {
          String name = pokemonDetailEntity?.stats[index]['name'] ?? '';
          int value = pokemonDetailEntity?.stats[index]['value'] ?? 0;

          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        value.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: 12),
                      statProgress(value: value),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget statProgress({required int value}) {
  double percent = (value / 255).clamp(0, 1);

  return Container(
    height: 6,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.grey.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Stack(
      children: [
        FractionallySizedBox(
          widthFactor: percent,
          child: Container(
            decoration: BoxDecoration(
              color: Utils.statColor(value),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    ),
  );
}
