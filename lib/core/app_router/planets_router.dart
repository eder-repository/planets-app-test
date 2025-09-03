import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/features/features.dart';
import 'package:planets_app_test/features/planets/planets.dart';
import 'package:planets_app_test/features/planets/presentatios/screens/not_found_screen.dart';
import 'package:planets_app_test/features/planets/presentatios/screens/planet_details_screen.dart';
import 'package:riverpod/riverpod.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    navigatorKey: _navigatorKey,
    initialLocation: PlanetsRoutes.splash.path,
    routes: PlanetsRouter.routes(),
    debugLogDiagnostics: ref.read(Providers.env).enableLogging,
    errorBuilder: (context, state) => NotFoundScreen(
      title: 'Página no encontrada',
      message: 'La ruta ${state.uri.path} no existe.',
      ctaText: 'Ir a Planet List',
      onTap: () => context.go('/planets'),
    ),
  ),
);

class PlanetsRouter {
  const PlanetsRouter._();

  static List<RouteBase> routes() => [
    GoRoute(
      path: PlanetsRoutes.splash.path,
      name: PlanetsRoutes.splash.name,
      builder: SplashScreen.builder,
    ),
    GoRoute(
      path: PlanetsRoutes.homePlanets.path,
      name: PlanetsRoutes.homePlanets.name,
      builder: HomeScreen.builder,
    ),

    GoRoute(
      path: PlanetsRoutes.planets.path,
      name: PlanetsRoutes.planets.name,
      builder: PlanetsScreen.builder,
    ),
    GoRoute(
      path: PlanetsRoutes.planetDetails.path,
      name: PlanetsRoutes.planetDetails.name,
      builder: PlanetDetailsScreen.builder,
    ),
    GoRoute(
      path: '/not-found',
      name: 'not_found',
      builder: (context, state) => NotFoundScreen(
        title: state.uri.queryParameters['title'] ?? 'No encontrado',
        message:
            state.uri.queryParameters['message'] ?? 'Recurso no disponible.',
        ctaText: 'Volver al listado',
        onTap: () => context.goNamed(PlanetsRoutes.planets.name),
      ),
    ),
  ];
}
