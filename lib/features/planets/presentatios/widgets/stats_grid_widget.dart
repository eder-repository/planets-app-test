import 'package:flutter/material.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';
import 'package:planets_app_test/i18n/translations.g.dart';

class StatsGridWidget extends StatelessWidget {
  const StatsGridWidget({required this.p, super.key});
  final Planet p;

  @override
  Widget build(BuildContext context) {
    final texts = context.texts.home.planet_details;
    final stats = <_Stat>[
      _Stat(
        texts.orbitalDistance,
        _fmtKm(p.orbitalDistanceKm),
        'km',
        Icons.swap_horiz_outlined,
      ),
      _Stat(
        texts.equatorialRadius,
        _fmtKm(p.equatorialRadiusKm),
        'km',
        Icons.public,
      ),
      _Stat(texts.volume, p.volumeKm3 ?? '—', 'km³', Icons.blur_circular),
      _Stat(texts.mass, p.massKg ?? '—', 'kg', Icons.scale),
      _Stat(
        texts.density,
        _fmtDouble(p.densityGCm3),
        'g/cm³',
        Icons.water_drop,
      ),
      _Stat(
        texts.surfaceGravity,
        _fmtDouble(p.surfaceGravityMS2),
        'm/s²',
        Icons.arrow_downward,
      ),
      _Stat(
        texts.escapeVelocity,
        _fmtKm(p.escapeVelocityKmh),
        'km/h',
        Icons.rocket_outlined,
      ),
      _Stat(
        texts.dayLength,
        _fmtDouble(p.dayLengthEarthDays),
        texts.earthDays,
        Icons.wb_sunny_outlined,
      ),
      _Stat(
        texts.yearLength,
        _fmtDouble(p.yearLengthEarthDays),
        texts.earthDays,
        Icons.calendar_month,
      ),
      _Stat(
        texts.orbitalSpeed,
        _fmtKm(p.orbitalSpeedKmh),
        'km/h',
        Icons.speed_outlined,
      ),
      _Stat(texts.moons, _fmtInt(p.moons), '', Icons.brightness_2_outlined),
    ];

    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        var cols = 2;
        if (w >= 1200) {
          cols = 4;
        } else if (w >= 900) {
          cols = 3;
        }

        return GridView.builder(
          itemCount: stats.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 110,
          ),
          itemBuilder: (_, i) => _StatTile(stat: stats[i]),
        );
      },
    );
  }
}

class _Stat {
  _Stat(this.label, this.value, this.suffix, this.icon);
  final String label;
  final String value;
  final String suffix;
  final IconData icon;
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.stat});
  final _Stat stat;

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: .08)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(stat.icon, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stat.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      text: stat.value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white70,
                      ),
                      children: [
                        if (stat.suffix.isNotEmpty) const TextSpan(text: ' '),
                        if (stat.suffix.isNotEmpty)
                          TextSpan(
                            text: stat.suffix,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _fmtInt(int? v) => v == null ? '—' : '$v';

String _fmtKm(int? v) {
  if (v == null) return '—';
  return _compactNumber(v);
}

String _fmtDouble(double? v) {
  if (v == null) return '—';
  final s = v.toStringAsFixed(v.truncateToDouble() == v ? 0 : 2);
  return s;
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
