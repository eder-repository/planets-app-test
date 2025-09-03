import 'package:flutter/material.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';
import 'package:planets_app_test/features/planets/planets.dart';
import 'package:planets_app_test/i18n/translations.g.dart';

class ContentMobileWidget extends StatelessWidget {
  const ContentMobileWidget({required this.p, super.key});
  final Planet p;

  @override
  Widget build(BuildContext context) {
    final texts = context.texts.home.planet_details;
    return Column(
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
            child: AtmosphereChipsWidget(composition: p.atmosphereComposition!),
          ),
        const SizedBox(height: 16),
        SectionCardWidget(
          title: texts.fastMetrict,
          padding: const EdgeInsets.all(16),
          child: StatsGridWidget(p: p),
        ),
      ],
    );
  }
}
