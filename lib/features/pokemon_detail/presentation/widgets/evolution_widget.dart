import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/base/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../domain/entities/evolution_entity.dart';

class EvolutionWidget extends StatelessWidget {
  const EvolutionWidget({
    super.key,
    required this.evolutionEntity,
    required this.color,
  });

  final List<EvolutionEntity> evolutionEntity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, left: 25, right: 25),
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        itemCount: evolutionEntity.length,
        itemBuilder: (context, index) {
          String num = Utils.getLastNumber(evolutionEntity[index].imgUrl);

          String imgUrl = '${AppStrings().imgPokemon}$num.png';
          String name = evolutionEntity[index].name;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: imgUrl,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                        memCacheWidth: 100,
                        memCacheHeight: 100,
                        placeholder: (context, url) => const SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Container(
                        width: 70,
                        height: 14,
                        transformAlignment: Alignment.center,
                        transform: Matrix4.diagonal3Values(3.4, 0.55, 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: RadialGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.14),
                              Colors.black.withValues(alpha: 0.02),
                              Colors.transparent,
                            ],
                            radius: 0.9,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: color.withAlpha(48),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: color.withAlpha(60), width: 1),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 10,
                    ),
                    child: Text(
                      Utils.capitalizeEachWord(name),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),

              if (index != evolutionEntity.length - 1 && name != '') ...[
                const SizedBox(height: 6),
                const Icon(Icons.arrow_downward, size: 28, color: Colors.grey),
                const SizedBox(height: 6),
              ],
            ],
          );
        },
      ),
    );
  }
}
