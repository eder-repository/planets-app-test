import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app_test/core/app_router/planets_routes.dart';
import 'package:planets_app_test/core/shared/shared.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';
import 'package:planets_app_test/features/planets/planets.dart';
import 'package:planets_app_test/i18n/translations.g.dart';

class PlanetCardWidget extends ConsumerStatefulWidget {
  const PlanetCardWidget({
    required this.planet,
    super.key,
    this.onFavoriteChanged,
    this.favoriteIds = const [],
  });

  final Planet planet;
  final ValueChanged<bool>? onFavoriteChanged;
  final List<String> favoriteIds;

  @override
  ConsumerState<PlanetCardWidget> createState() => _PlanetCardState();
}

class _PlanetCardState extends ConsumerState<PlanetCardWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final texts = context.texts.home.planet_details;
    final p = widget.planet;
    final theme = Theme.of(context);
    ref.listen(setFavoriteProvider, (_, state) {
      if (state is FavoriteLoaded) {
        ref.invalidate(favoriteListProvider);
      }
    });
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _hover ? 1.02 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .005),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withValues(alpha: .08)),
            boxShadow: [
              if (_hover)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0x221C2E5C), Color(0x221B2A4A)],
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PlanetsResponsiveBuilder(
                    desktop: (_) => _ImageWidget(
                      p: p,
                    ),
                    mobile: (_) => _ImageWidget(
                      p: p,
                      aspectRatio: .6,
                    ),
                    tablet: (_) => _ImageWidget(
                      p: p,
                    ),
                  ),
                  PlanetsResponsiveBuilder(
                    desktop: (_) => const SizedBox(width: 14),
                    mobile: (_) => const SizedBox(width: 4),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                p.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            IconButton(
                              tooltip:
                                  widget.favoriteIds.contains(
                                    p.name.toLowerCase(),
                                  )
                                  ? texts.unfavorite
                                  : texts.favorite,
                              onPressed: () {
                                ref
                                    .read(setFavoriteProvider.notifier)
                                    .setFavorite(
                                      isFavorite: !widget.favoriteIds.contains(
                                        p.name.toLowerCase(),
                                      ),
                                      planetId: p.name.toLowerCase(),
                                    );
                              },
                              icon: Icon(
                                widget.favoriteIds.contains(
                                      p.name.toLowerCase(),
                                    )
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    widget.favoriteIds.contains(
                                      p.name.toLowerCase(),
                                    )
                                    ? Colors.pinkAccent
                                    : Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            DataChipWidget(
                              icon: Icons.public,
                              label: _fmtKm(
                                p.equatorialRadiusKm,
                                suffix: ' km radius',
                              ),
                            ),
                            DataChipWidget(
                              icon: Icons.science,
                              label: _fmtDouble(
                                p.surfaceGravityMS2,
                                suffix: ' m/s²',
                              ),
                            ),
                            DataChipWidget(
                              icon: Icons.brightness_2_outlined,
                              label: _fmtInt(
                                p.moons,
                                suffix: ' ${texts.moons}',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Text(
                            p.description ?? '—',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                              height: 1.25,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton.icon(
                            onPressed: () {
                              context.pushNamed(
                                PlanetsRoutes.planetDetails.name,
                                pathParameters: {'id': p.name.toLowerCase()},
                              );
                            },
                            icon: const Icon(Icons.open_in_new, size: 18),
                            label: Text(
                              texts.viewDetails,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _fmtInt(int? v, {String suffix = ''}) {
    if (v == null) return '—';
    return '$v$suffix';
  }

  String _fmtKm(int? v, {String suffix = ''}) {
    if (v == null) return '—';
    final s = _compactNumber(v);
    return '$s$suffix';
  }

  String _fmtDouble(double? v, {String suffix = ''}) {
    if (v == null) return '—';
    final s = v.toStringAsFixed(v.truncateToDouble() == v ? 0 : 2);
    return '$s$suffix';
  }

  String _compactNumber(num n) {
    const units = ['', 'K', 'M', 'B', 'T'];
    var value = n.toDouble();
    var unit = 0;
    while (value.abs() >= 1000 && unit < units.length - 1) {
      value /= 1000;
      unit++;
    }
    final str = value.toStringAsFixed(value < 10 && unit > 0 ? 1 : 0);
    return '$str${units[unit]}';
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    required this.p,
    this.aspectRatio = 1,
  });

  final Planet p;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: fixImageUrl(p.image),

              fit: aspectRatio == 1 ? BoxFit.cover : BoxFit.contain,
              placeholder: (_, __) => Container(color: const Color(0x22FFFFFF)),
              errorWidget: (_, __, ___) => const Icon(
                Icons.public,
                color: Colors.white38,
                applyTextScaling: true,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.45),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String fixImageUrl(String url) {
  if (!kIsWeb) return url;
  final uri = Uri.parse(url);
  if (uri.scheme == 'http') {
    return 'https://images.weserv.nl/?url=${uri.host}${uri.path}';
  }
  return 'https://images.weserv.nl/?url=${uri.host}${uri.path}';
}
