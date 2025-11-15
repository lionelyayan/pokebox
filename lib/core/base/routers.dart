import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_strings.dart';
import '../../features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../features/pokemon_list/presentation/pages/pokemon_list_page.dart';

class Routers {
  get router => GoRouter(
    routes: [
      GoRoute(
        path: AppStrings().listPokemonRoute,
        name: AppStrings().listPokemonRoute,
        pageBuilder: (context, state) {
          return NoTransitionPage(child: PokemonListPage());
        },
        routes: [
          GoRoute(
            path: AppStrings().detailPokemonRoute,
            name: AppStrings().detailPokemonRoute,
            pageBuilder: (context, state) {
              int id = 0;
              String imgUrl = '';
              Color color = Colors.white;

              if (state.extra != null) {
                final data = state.extra as Map<String, dynamic>;
                id = data['id'] ?? 0;
                imgUrl = data['imgUrl'] ?? '';
                color = data['color'] ?? Colors.white;
              }
              return CustomTransitionPage(
                child: PokemonDetailPage(id: id, imgUrl: imgUrl, color: color),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0.0, 0.1),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutCubic,
                              ),
                            ),
                        child: FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: Tween<double>(begin: 0.98, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOut,
                              ),
                            ),
                            child: child,
                          ),
                        ),
                      );
                    },
                transitionDuration: const Duration(milliseconds: 300),
              );
            },
          ),
        ],
      ),
    ],
  );
}
