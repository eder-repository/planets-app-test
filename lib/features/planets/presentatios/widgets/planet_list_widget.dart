import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';
import 'package:planets_app_test/features/planets/planets.dart';
import 'package:planets_app_test/i18n/translations.g.dart';

class PlanetListWidget extends ConsumerStatefulWidget {
  const PlanetListWidget({
    required this.planets,
    required this.title,
    super.key,
    this.onToggleFavorite,
  });

  final List<Planet> planets;
  final void Function(Planet planet, bool newValue)? onToggleFavorite;
  final String title;

  @override
  ConsumerState<PlanetListWidget> createState() => _PlanetListPageState();
}

class _PlanetListPageState extends ConsumerState<PlanetListWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white70,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.goNamed(PlanetsRoutes.homePlanets.name);
            }
          },
        ),
        title: Text(widget.title),
        centerTitle: false,
        elevation: 0,
        actions: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _SearchField(
                hintText: context.texts.home.planet_details.searchPlaceholder,
                onChanged: (v) => ref.read(queryNotifier.notifier).state = v,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
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
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: PlanetsResponsiveBuilder(
              mobile: (_) => GridWidget(
                planets: widget.planets,
                columns: 1,
                onToggleFavorite: widget.onToggleFavorite,
              ),
              tablet: (_) => GridWidget(
                planets: widget.planets,
                columns: 1,
                onToggleFavorite: widget.onToggleFavorite,
              ),
              desktop: (context) {
                final width = MediaQuery.of(context).size.width;
                final cols = width >= 1000 ? 2 : 1;
                return GridWidget(
                  planets: widget.planets,
                  columns: cols,
                  onToggleFavorite: widget.onToggleFavorite,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.hintText, this.onChanged});
  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        prefixIcon: const Icon(Icons.search),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
