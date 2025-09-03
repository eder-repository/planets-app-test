import 'package:flutter/material.dart';

class DataChipWidget extends StatelessWidget {
  const DataChipWidget({required this.icon, required this.label, super.key});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.black),
      label: Text(label, style: const TextStyle(color: Colors.black)),
      backgroundColor: Colors.grey.withValues(alpha: .08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(
        color: Colors.white.withValues(alpha: .08),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    );
  }
}
