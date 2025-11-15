import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/app_strings.dart';
import '../../../../core/base/injection.dart';
import '../../../../core/base/widgets/pagination.dart';
import '../../../../core/base/widgets/responsive_widget.dart';
import '../../../../utils/utils.dart';
import '../../domain/entities/pokemon_list_entity.dart';
import '../bloc/pokemon_list_bloc.dart';
import '../widgets/pokemon_grid_widget.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final pokemonListBlock = injection<PokemonListBloc>();
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  int count = 0;
  int offset = 0;
  int limit = 20;
  bool isLoading = false;
  bool isError = false;

  PokemonListEntity? pokemonList;

  Future<void> _loadData() async {
    pokemonListBlock.add(GetListPokemonEvent(limit, offset));
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

  @override
  Widget build(BuildContext context) {
    Utils.setStatusBarLight();

    return Scaffold(
      body: SafeArea(
        child: BlocListener<PokemonListBloc, PokemonListState>(
          bloc: pokemonListBlock,
          listener: (context, state) {
            setState(() {
              if (state is GetListPokemonStateLoading) {
                isLoading = true;
                isError = false;
              } else if (state is GetListPokemonStateError) {
                isLoading = false;
                isError = true;
              } else if (state is GetListPokemonStateLoaded) {
                isLoading = false;
                isError = false;
                pokemonList = state.pokemonListEntity;
                count = pokemonList?.count ?? 0;
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
    child: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          pinned: true,
          stretch: true,
          expandedHeight: 130,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final double top = constraints.biggest.height;
              final bool isCollapsed = top <= kToolbarHeight + 50;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                color: isCollapsed
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                child: FlexibleSpaceBar(
                  centerTitle: true,
                  title: isCollapsed
                      ? Text(
                          AppStrings().appTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : null,
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppStrings().assetsHeader),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: !isCollapsed
                        ? Text(
                            AppStrings().appTitle,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        : null,
                  ),
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 5)),
        if (isLoading)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator.adaptive()),
          )
        else
          PokemonGridWidget(
            listPokemon: pokemonList?.results ?? [],
            crossAxisCount: 2,
          ),
        if (!isLoading && pokemonList?.results.isNotEmpty == true)
          SliverPadding(
            padding: EdgeInsets.all(15),
            sliver: SliverToBoxAdapter(
              child: pagination(
                context: context,
                currentPage: Utils.getCurrentPage(offset, limit),
                totalPage: Utils.getTotalPage(count, limit),
                visibleCount: 3,
                onPageChange: (page) {
                  offset = (page - 1) * limit;
                  _loadData();
                },
              ),
            ),
          ),
      ],
    ),
  );

  Widget buildLandscape() => RefreshIndicator(
    key: refreshKey,
    onRefresh: () => _loadData(),
    child: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          pinned: true,
          stretch: true,
          expandedHeight: 120,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final double top = constraints.biggest.height;
              final bool isCollapsed = top <= kToolbarHeight + 50;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                color: isCollapsed
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                child: FlexibleSpaceBar(
                  centerTitle: true,
                  title: isCollapsed
                      ? Text(
                          AppStrings().appTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : null,
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppStrings().assetsHeader),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: !isCollapsed
                        ? Text(
                            AppStrings().appTitle,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        : null,
                  ),
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 5)),
        if (isLoading)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator.adaptive()),
          )
        else
          PokemonGridWidget(
            listPokemon: pokemonList?.results ?? [],
            crossAxisCount: 4,
          ),
        if (!isLoading && pokemonList?.results.isNotEmpty == true)
          SliverPadding(
            padding: EdgeInsets.all(15),
            sliver: SliverToBoxAdapter(
              child: pagination(
                context: context,
                currentPage: Utils.getCurrentPage(offset, limit),
                totalPage: Utils.getTotalPage(count, limit),
                visibleCount: 6,
                onPageChange: (page) {
                  offset = (page - 1) * limit;
                  _loadData();
                },
              ),
            ),
          ),
      ],
    ),
  );
}
