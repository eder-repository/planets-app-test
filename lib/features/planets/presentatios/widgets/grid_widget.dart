import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';
import 'package:planets_app_test/features/planets/planets.dart';
import 'package:planets_app_test/i18n/translations.g.dart';

class GridWidget extends ConsumerWidget {
  const GridWidget({
    required this.planets,
    required this.columns,
    super.key,
    this.onToggleFavorite,
  });

  final List<Planet> planets;
  final int columns;
  final void Function(Planet planet, bool newValue)? onToggleFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final texts = context.texts.home;
    if (planets.isEmpty) {
      return Center(
        child: Text(
          texts.noFound,
          style: const TextStyle(color: Colors.white70),
        ),
      );
    }

    return switch (ref.watch(favoriteListProvider)) {
      FavoriteListLoading() => const Center(
        child: CircularProgressIndicator(
          color: Colors.white70,
        ),
      ),

      FavoriteListLoaded(:final favoriteIds) => GridView.builder(
        itemCount: planets.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisExtent: 250,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, i) {
          final p = planets[i];
          return PlanetCardWidget(
            planet: p,
            favoriteIds: favoriteIds,
            onFavoriteChanged: (v) => onToggleFavorite?.call(p, v),
          );
        },
      ),

      FavoriteListError() => Center(
        child: Text(context.texts.home.error),
      ),
    };
  }
}
