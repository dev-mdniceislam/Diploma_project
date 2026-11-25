import 'dart:math';

import 'package:diploma_job/core/theme/orbit_palette.dart';
import 'package:flutter/material.dart';

class OrbitLogo extends StatefulWidget {
  const OrbitLogo({super.key});

  @override
  State<OrbitLogo> createState() => _OrbitLogoState();
}

class _OrbitLogoState extends State<OrbitLogo> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Container(
        width: 44,
        height: 44,
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: p.brandGradient,
          boxShadow: [
            BoxShadow(
              color: p.indigo.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.5),
          ),
          child: Center(
            child: AnimatedRotation(
              turns: _hover ? 0.125 : 0,
              duration: const Duration(milliseconds: 500),
              child: CustomPaint(
                size: const Size.square(24),
                painter: _OrbitMarkPainter(p.indigo, p.cyan, p.amber),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// HTML SVG (viewBox 24) কে scale করে আঁকা।
class _OrbitMarkPainter extends CustomPainter {
  const _OrbitMarkPainter(this.indigo, this.cyan, this.amber);

  final Color indigo;
  final Color cyan;
  final Color amber;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 24);

    canvas.drawCircle(const Offset(12, 12), 3, Paint()..color = indigo);
    canvas.drawCircle(
      const Offset(12, 12),
      3,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = indigo.withValues(alpha: 0.6),
    );

    // tilted orbit ellipse (rx 10, ry 4.5, rotate -28°)
    canvas.save();
    canvas.translate(12, 12);
    canvas.rotate(-28 * pi / 180);
    final orbitPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = LinearGradient(colors: [indigo, cyan]).createShader(
        const Rect.fromLTRB(-10, -10, 10, 10),
      );
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: 20, height: 9),
      orbitPaint,
    );
    canvas.restore();

    canvas.drawCircle(const Offset(19.5, 7.5), 1.7, Paint()..color = amber);
  }

  @override
  bool shouldRepaint(_OrbitMarkPainter old) =>
      old.indigo != indigo || old.cyan != cyan || old.amber != amber;
}
