import 'package:planets_app_test/features/planets/domain/entities/entities.dart';

String _stripDiacritics(String input) {
  const from = 'áàäâãéèëêíìïîóòöôõúùüûñçÁÀÄÂÃÉÈËÊÍÌÏÎÓÒÖÔÕÚÙÜÛÑÇ';
  const to = 'aaaaaeeeeiiiiooooouuuuncAAAAAEEEEIIIIOOOOOUUUUNC';
  final map = {for (var i = 0; i < from.length; i++) from[i]: to[i]};
  return input.split('').map((c) => map[c] ?? c).join();
}

String _normalize(String s) {
  final lower = _stripDiacritics(
    s.toLowerCase(),
  ).replaceAll(',', '.').replaceAll(RegExp(r'\s+'), ' ').trim();
  return lower;
}

String _nNum(num? n) {
  if (n == null) return '';
  final s = (n is int) ? n.toString() : n.toString();
  final trimmed = s
      .replaceFirst(RegExp(r'([.]\d*?)0+$'), r'$1')
      .replaceFirst(RegExp(r'[.]$'), '');
  return _normalize(trimmed);
}

String buildSearchIndex(Planet p) {
  final parts = <String>[
    p.name,
    p.image,
    p.massKg ?? '',
    p.volumeKm3 ?? '',
    p.atmosphereComposition ?? '',
    p.description ?? '',
    _nNum(p.densityGCm3),
    _nNum(p.surfaceGravityMS2),
    _nNum(p.dayLengthEarthDays),
    _nNum(p.yearLengthEarthDays),
    _nNum(p.orbitalDistanceKm),
    _nNum(p.equatorialRadiusKm),
    _nNum(p.orbitalSpeedKmh),
    _nNum(p.escapeVelocityKmh),
    _nNum(p.moons),
  ];

  return _normalize(
    parts.where((e) => e.trim().isNotEmpty).join(' '),
  );
}

bool planetMatches(Planet p, String query) {
  final q = _normalize(query);
  if (q.isEmpty) return true;
  final tokens = q.split(' ').where((t) => t.isNotEmpty).toList();
  final index = buildSearchIndex(p);
  return tokens.every(index.contains);
}
