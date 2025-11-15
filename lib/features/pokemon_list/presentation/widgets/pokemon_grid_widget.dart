import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/base/app_strings.dart';
import '../../../../core/base/injection.dart';
import '../../../../utils/Utils.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../bloc/pokemon_list_bloc.dart';

class PokemonGridWidget extends StatelessWidget {
  const PokemonGridWidget({
    super.key,
    required this.listPokemon,
    required this.crossAxisCount,
  });

  final List<PokemonEntity> listPokemon;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 1.2,
        ),

        delegate: SliverChildBuilderDelegate((context, index) {
          final pokemon = listPokemon[index];
          final cardColor = Utils.getColorFromName(pokemon.name);

          return GestureDetector(
            onTap: () {
              context.goNamed(
                AppStrings().detailPokemonRoute,
                extra: {
                  "id": pokemon.id,
                  "imgUrl": pokemon.imgUrl,
                  "color": cardColor,
                },
              );
            },
            child: RepaintBoundary(
              child: Card(
                color: cardColor,
                clipBehavior: Clip.antiAlias,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          pokemon.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Image.asset(
                                    AppStrings().assetsBgPokemon,
                                    fit: BoxFit.cover,
                                  ),
                                  CachedNetworkImage(
                                    imageUrl: pokemon.imgUrl,
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                    memCacheWidth: 100,
                                    memCacheHeight: 100,
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<PokemonListBloc, PokemonListState>(
                              bloc: injection<PokemonListBloc>()
                                ..add(GetDetailPokemonEvent(pokemon.id)),
                              builder: (context, state) {
                                if (state is GetDetailPokemonStateLoading) {
                                  return Wrap(
                                    spacing: 6,
                                    runSpacing: 4,
                                    direction: Axis.vertical,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(80),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(80),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                if (state is GetDetailPokemonStateLoaded) {
                                  final types = state.pokemonDetailEntity.types;
                                  return Wrap(
                                    spacing: 6,
                                    runSpacing: 4,
                                    direction: Axis.vertical,
                                    children: [
                                      for (var type in types)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white.withAlpha(128),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            border: Border.all(
                                              color: Colors.white.withAlpha(
                                                140,
                                              ),
                                              width: 1,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 10,
                                          ),
                                          child: Text(
                                            type,
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }, childCount: listPokemon.length),
      ),
    );
  }
}
