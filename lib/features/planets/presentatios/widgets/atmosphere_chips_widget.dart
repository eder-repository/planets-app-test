import 'package:flutter/material.dart';

class AtmosphereChipsWidget extends StatelessWidget {
  const AtmosphereChipsWidget({required this.composition, super.key});
  final String composition;

  @override
  Widget build(BuildContext context) {
    final items = composition
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList(growable: false);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .map(
            (s) => Chip(
              label: Text(s, style: const TextStyle(color: Colors.black)),
              backgroundColor: Colors.white.withValues(alpha: .08),
              side: BorderSide(color: Colors.white.withValues(alpha: .1)),
            ),
          )
          .toList(),
    );
  }
}
