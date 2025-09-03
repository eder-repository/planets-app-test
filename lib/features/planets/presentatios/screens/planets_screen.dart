import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/features/planets/planets.dart';
import 'package:planets_app_test/i18n/translations.g.dart';

final StateProvider<String> queryNotifier = StateProvider((_) => '');

class PlanetsScreen extends ConsumerWidget {
  const PlanetsScreen._();

  static Widget builder(BuildContext _, GoRouterState __) {
    return const PlanetsScreen._();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 4),
          Expanded(
            child: switch (ref.watch(planetsProvider)) {
              PlanetsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              PlanetsLoaded(:final planets) => Builder(
                builder: (context) {
                  final q = ref.watch(queryNotifier);
                  final filtered = planets.where((p) {
                    final ok = planetMatches(p, q);
                    return ok;
                  }).toList();

                  return PlanetListWidget(
                    title: context.texts.home.planets_app,
                    planets: filtered,
                  );
                },
              ),
              PlanetsError() => Center(child: Text(texts.home.error)),
            },
          ),
        ],
      ),
    );
  }
}
