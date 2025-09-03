import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/features/planets/domain/entities/entities.dart';
import 'package:planets_app_test/features/planets/planets.dart';
import 'package:planets_app_test/i18n/translations.g.dart';

class PlanetDetailsScreen extends ConsumerStatefulWidget {
  const PlanetDetailsScreen._(this.id, {super.key});
  final String? id;

  static Widget builder(BuildContext context, GoRouterState state) {
    final id = state.pathParameters['id'];
    return PlanetDetailsScreen._(key: ValueKey('planet:$id'), id ?? '');
  }

  @override
  ConsumerState<PlanetDetailsScreen> createState() =>
      _PlanetDetailsScreenState();
}

class _PlanetDetailsScreenState extends ConsumerState<PlanetDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id == null || widget.id!.isEmpty) {
        return;
      }
      ref
          .read(planetsDetailsProvider.notifier)
          .byId(id: widget.id!.toLowerCase());
    });
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id == null || widget.id!.isEmpty) {
        return;
      }
      ref
          .read(planetsDetailsProvider.notifier)
          .byId(id: widget.id!.toLowerCase());
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final texts = context.texts.home;
    return switch (ref.watch(planetsDetailsProvider)) {
      PlanetsDetailsLoading() => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      PlanetsDetailsError() => NotFoundScreen(
        title: texts.noFound,
        message: texts.notFoundDetails,
        ctaText: texts.goBack,
        onTap: () => context.goNamed(PlanetsRoutes.planets.name),
      ),
      PlanetsDetailsLoaded(:final planet) => Scaffold(
        body: _Body(planet),
      ),
    };
  }
}

class _Body extends ConsumerWidget {
  const _Body(this.p);
  final Planet p;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final texts = context.texts.home.planet_details;
    final favState = ref.watch(favoriteListProvider);
    final favoriteIds = switch (favState) {
      FavoriteListLoaded(:final favoriteIds) => favoriteIds,
      _ => const <String>[],
    };
    final planetId = p.name.toLowerCase();
    final isFav = favoriteIds.contains(planetId);

    ref.listen(setFavoriteProvider, (_, state) {
      if (state is FavoriteLoaded) ref.invalidate(favoriteListProvider);
    });

    final width = MediaQuery.of(context).size.width;
    final expandedHeight = width >= 1200
        ? 440.0
        : width >= 900
        ? 380.0
        : 300.0;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(PlanetsRoutes.planets.name);
              }
            },
          ),
          expandedHeight: expandedHeight,
          pinned: true,
          backgroundColor: const Color(0xFF0B1020),
          actions: [
            IconButton(
              tooltip: isFav ? texts.unfavorite : texts.favorite,
              onPressed: () {
                ref
                    .read(setFavoriteProvider.notifier)
                    .setFavorite(
                      planetId: planetId,
                      isFavorite: !isFav,
                    );
              },
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.pinkAccent : Colors.white,
              ),
            ),
            const SizedBox(width: 8),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(
              start: 56,
              bottom: 14,
              end: 16,
            ),
            title: Text(
              p.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,

              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: fixImageUrl(p.image),
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                      Container(color: const Color(0x22000000)),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.public,
                    color: Colors.white38,
                    size: 64,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, .6, 1.0],
                      colors: [
                        Colors.transparent,
                        Color(0xAA0B1020),
                        Color(0xFF0B1020),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, .35, 1],
                colors: [
                  Color(0xFF0B1020),
                  Color(0xFF0F1430),
                  Color(0xFF121633),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: PlanetsResponsiveBuilder(
                mobile: (_) => ContentMobileWidget(p: p),
                tablet: (_) => _ContentTwoCols(p: p, leftFlex: 1, rightFlex: 1),
                desktop: (_) =>
                    _ContentTwoCols(p: p, leftFlex: 2, rightFlex: 3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContentTwoCols extends StatelessWidget {
  const _ContentTwoCols({
    required this.p,
    required this.leftFlex,
    required this.rightFlex,
  });

  final Planet p;
  final int leftFlex;
  final int rightFlex;

  @override
  Widget build(BuildContext context) {
    final texts = context.texts.home.planet_details;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: leftFlex,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionCardWidget(
                title: texts.overview,
                child: Text(
                  p.description ?? texts.noDescription,
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.35,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if ((p.atmosphereComposition ?? '').isNotEmpty)
                SectionCardWidget(
                  title: texts.atmosphere,
                  child: AtmosphereChipsWidget(
                    composition: p.atmosphereComposition!,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: rightFlex,
          child: SectionCardWidget(
            title: texts.fastMetrict,
            padding: const EdgeInsets.all(16),
            child: StatsGridWidget(p: p),
          ),
        ),
      ],
    );
  }
}
