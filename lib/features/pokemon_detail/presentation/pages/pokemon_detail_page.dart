import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/app_strings.dart';
import '../../../../core/base/injection.dart';
import '../../../../core/base/widgets/responsive_widget.dart';
import '../../../../utils/utils.dart';
import '../../../pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import '../../domain/entities/evolution_entity.dart';
import '../../domain/entities/moves_entity.dart';
import '../../domain/entities/pokemon_detail_entity.dart';
import '../widgets/about_widget.dart';
import '../widgets/evolution_widget.dart';
import '../widgets/move_widget.dart';
import '../widgets/stat_widget.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({
    super.key,
    required this.id,
    required this.imgUrl,
    required this.color,
  });

  final int id;
  final String imgUrl;
  final Color color;

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  final pokemonListBlock = injection<PokemonListBloc>();
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  bool isLoading = false;
  bool isError = false;
  String id = '';
  String nama = '';

  PokemonDetailEntity? pokemonDetailEntity;
  List<EvolutionEntity> evolutionEntity = [];
  List<MovesEntity> movesEntity = [];

  Future<void> _loadData() async {
    pokemonListBlock.add(GetDetailPokemonEvent(widget.id));
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getSpecies(String url) async {
    if (url != '') {
      pokemonListBlock.add(GetSpeciesEvent(url));
    }
  }

  Future<void> _getEvolution(String url) async {
    if (url != '') {
      pokemonListBlock.add(GetEvolutionEvent(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    Utils.setStatusBarLight();

    return Scaffold(
      body: SafeArea(
        child: BlocListener<PokemonListBloc, PokemonListState>(
          bloc: pokemonListBlock,
          listener: (context, state) {
            setState(() {
              if (state is GetDetailPokemonStateLoading) {
                isLoading = true;
                isError = false;
                pokemonDetailEntity = null;
                movesEntity.clear();
              } else if (state is GetDetailPokemonStateError) {
                isLoading = false;
                isError = true;
                pokemonDetailEntity = null;
                movesEntity.clear();
              } else if (state is GetDetailPokemonStateLoaded) {
                isLoading = false;
                isError = false;
                pokemonDetailEntity = null;
                movesEntity.clear();
                pokemonDetailEntity = state.pokemonDetailEntity;
                movesEntity.addAll(pokemonDetailEntity?.moves ?? []);
                _getSpecies(pokemonDetailEntity?.urlSpecies ?? '');
              } else if (state is GetSpeciesStateLoading) {
                evolutionEntity.clear();
              } else if (state is GetSpeciesStateError) {
                evolutionEntity.clear();
              } else if (state is GetSpeciesStateLoaded) {
                evolutionEntity.clear();
                _getEvolution(state.speciesEntity.url);
              } else if (state is GetEvolutionStateLoading) {
                evolutionEntity.clear();
              } else if (state is GetEvolutionStateError) {
                evolutionEntity.clear();
              } else if (state is GetEvolutionStateLoaded) {
                evolutionEntity.clear();
                evolutionEntity.addAll(state.evolutionEntity);
              }
            });
          },
          child: ResponsiveWidget(
            portrait: buildPortrait(),
            landscape: buildLandscape(),
          ),
        ),
      ),
    );
  }

  Widget buildPortrait() => RefreshIndicator(
    key: refreshKey,
    onRefresh: () => _loadData(),
    child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              color: widget.color,
              height: MediaQuery.of(context).size.height,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.58,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: DynamicTabBarWidget(
                  dynamicTabs: [
                    TabData(
                      index: 0,
                      title: Tab(text: 'About'),
                      content: AboutWidget(
                        pokemonDetailEntity: pokemonDetailEntity,
                      ),
                    ),
                    TabData(
                      index: 1,
                      title: Tab(text: 'Base Stats'),
                      content: StatWidget(
                        pokemonDetailEntity: pokemonDetailEntity,
                      ),
                    ),
                    TabData(
                      index: 2,
                      title: Tab(text: 'Evolution'),
                      content: EvolutionWidget(
                        evolutionEntity: evolutionEntity,
                        color: widget.color,
                      ),
                    ),
                    TabData(
                      index: 3,
                      title: Tab(text: 'Moves'),
                      content: MoveWidget(
                        movesEntity: movesEntity,
                        color: widget.color,
                      ),
                    ),
                  ],
                  onTabControllerUpdated: (controller) {
                    controller.index = 0;
                  },
                  onTabChanged: (index) {
                    debugPrint("Tab changed: $index");
                  },
                  isScrollable: true,
                  indicatorColor: widget.color,
                  labelColor: widget.color,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  tabAlignment: TabAlignment.center,
                  padding: EdgeInsets.only(top: 40),
                  dividerColor: Colors.transparent,
                  showBackIcon: false,
                  showNextIcon: false,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 15,
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Utils.capitalizeEachWord(pokemonDetailEntity?.name ?? ''),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          direction: Axis.horizontal,
                          children: [
                            for (var type in pokemonDetailEntity?.types ?? [])
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(128),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withAlpha(140),
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
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Text(
                          '#${(pokemonDetailEntity?.id ?? 0).toString().padLeft(3, '0')}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 30,
                                sigmaY: 30,
                              ),
                              child: Container(
                                width: 260,
                                height: 260,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.4),
                                ),
                              ),
                            ),
                            Image.asset(
                              AppStrings().assetsBgPokemon,
                              fit: BoxFit.cover,
                              height: 200,
                              width: 200,
                            ),
                          ],
                        ),
                        CachedNetworkImage(
                          imageUrl: widget.imgUrl,
                          fit: BoxFit.cover,
                          width: 240,
                          height: 240,
                          memCacheWidth: 260,
                          memCacheHeight: 260,
                          placeholder: (context, url) => const SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ],
                    ),
                    Container(
                      width: 240,
                      height: 24,
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
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildLandscape() {
    final size = MediaQuery.of(context).size;
    final halfHeight = size.height;

    return RefreshIndicator(
      key: refreshKey,
      onRefresh: () => _loadData(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: halfHeight,
          color: widget.color,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            Utils.capitalizeEachWord(
                              pokemonDetailEntity?.name ?? '',
                            ),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 6,
                            children: [
                              for (var type in pokemonDetailEntity?.types ?? [])
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            '#${(pokemonDetailEntity?.id ?? 0).toString().padLeft(3, '0')}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaX: 20,
                                      sigmaY: 20,
                                    ),
                                    child: Container(
                                      width: 190,
                                      height: 190,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withValues(
                                          alpha: 0.4,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    AppStrings().assetsBgPokemon,
                                    fit: BoxFit.cover,
                                    height: 130,
                                    width: 130,
                                  ),
                                ],
                              ),
                              CachedNetworkImage(
                                imageUrl: widget.imgUrl,
                                fit: BoxFit.cover,
                                width: 170,
                                height: 170,
                                memCacheWidth: 190,
                                memCacheHeight: 190,
                                placeholder: (context, url) => const SizedBox(
                                  width: 130,
                                  height: 130,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ],
                          ),
                          Container(
                            width: 260,
                            height: 16,
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
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DynamicTabBarWidget(
                      dynamicTabs: [
                        TabData(
                          index: 0,
                          title: const Tab(text: 'About'),
                          content: AboutWidget(
                            pokemonDetailEntity: pokemonDetailEntity,
                          ),
                        ),
                        TabData(
                          index: 1,
                          title: const Tab(text: 'Base Stats'),
                          content: StatWidget(
                            pokemonDetailEntity: pokemonDetailEntity,
                          ),
                        ),
                        TabData(
                          index: 2,
                          title: const Tab(text: 'Evolution'),
                          content: EvolutionWidget(
                            evolutionEntity: evolutionEntity,
                            color: widget.color,
                          ),
                        ),
                        TabData(
                          index: 3,
                          title: const Tab(text: 'Moves'),
                          content: MoveWidget(
                            movesEntity: movesEntity,
                            color: widget.color,
                          ),
                        ),
                      ],
                      onTabControllerUpdated: (controller) {
                        controller.index = 0;
                      },
                      onTabChanged: (index) {
                        debugPrint("Tab changed: $index");
                      },
                      isScrollable: true,
                      indicatorColor: widget.color,
                      labelColor: widget.color,
                      unselectedLabelColor: Colors.black,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                      padding: const EdgeInsets.only(top: 8),
                      dividerColor: Colors.transparent,
                      showBackIcon: false,
                      showNextIcon: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
