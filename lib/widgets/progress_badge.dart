// lib/widgets/progress_badge.dart
import 'package:flutter/material.dart';

class ProgressBadge extends StatelessWidget {
  final int level;
  final double xpPercent;

  const ProgressBadge({required this.level, required this.xpPercent});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color.withOpacity(0.15), color.withOpacity(0.05)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Lv', style: TextStyle(fontSize: 12, color: color)),
            Text('$level', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
