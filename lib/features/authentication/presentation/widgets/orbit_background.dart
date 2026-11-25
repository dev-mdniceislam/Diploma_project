import 'dart:math';

import 'package:diploma_job/core/theme/orbit_palette.dart';
import 'package:flutter/material.dart';

/// Left panel background — gradient, blueprint grid, pulsing auroras।
class ShowcaseBackground extends StatefulWidget {
  const ShowcaseBackground({super.key, required this.child});

  final Widget child;

  @override
  State<ShowcaseBackground> createState() => _ShowcaseBackgroundState();
}

class _ShowcaseBackgroundState extends State<ShowcaseBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 4500),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [p.showcaseStart, p.canvas, p.showcaseEnd],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPainter(
                  p.indigo.withValues(alpha: 0.055),
                  p.cyan.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              top: -112,
              left: -112,
              child: AnimatedBuilder(
                animation: _pulse,
                builder: (_, child) => Opacity(
                  opacity: 0.55 + 0.3 * _pulse.value,
                  child: Transform.scale(
                    scale: 1 + 0.05 * _pulse.value,
                    child: child,
                  ),
                ),
                child: _Aura(size: 384, color: p.indigo.withValues(alpha: 0.25)),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: _Aura(size: 416, color: p.cyan.withValues(alpha: 0.35)),
            ),
            Positioned.fill(
              child: Center(
                child: _Aura(size: 288, color: p.violet.withValues(alpha: 0.25)),
              ),
            ),
            // Content must be the last child so it sits on top of the background.
            // It is non-positioned, so it decides the Stack's size.
            widget.child,
          ],
        ),
      ),
    );
  }
}


class _Aura extends StatelessWidget {
  const _Aura({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      );
}

class _GridPainter extends CustomPainter {
  const _GridPainter(this.vertical, this.horizontal);

  final Color vertical;
  final Color horizontal;

  static const _step = 44.0;

  @override
  void paint(Canvas canvas, Size size) {
    final vPaint = Paint()..color = vertical;
    final hPaint = Paint()..color = horizontal;
    for (var x = 0.0; x <= size.width; x += _step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), vPaint);
    }
    for (var y = 0.0; y <= size.height; y += _step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), hPaint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) =>
      old.vertical != vertical || old.horizontal != horizontal;
}

// ─── Daylight motes (twinkling dust) ───────────────────────────

class DaylightMotes extends StatefulWidget {
  const DaylightMotes({super.key, this.count = 55});

  final int count;

  @override
  State<DaylightMotes> createState() => _DaylightMotesState();
}

class _DaylightMotesState extends State<DaylightMotes>
    with SingleTickerProviderStateMixin {
  final _random = Random();
  late final List<_Mote> _motes =
      List.generate(widget.count, (_) => _Mote.random(_random));
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 60),
  )..repeat();

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return IgnorePointer(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _MotesPainter(_motes, _clock, p.indigo, p.cyan),
        ),
      ),
    );
  }
}

class _Mote {
  const _Mote({
    required this.x,
    required this.y,
    required this.radius,
    required this.phase,
    required this.speed,
    required this.isIndigo,
  });

  factory _Mote.random(Random r) => _Mote(
        x: r.nextDouble(),
        y: r.nextDouble(),
        radius: r.nextDouble() * 2.2 + 0.8,
        phase: r.nextDouble(),
        speed: r.nextDouble() * 0.5 + 0.5,
        isIndigo: r.nextBool(),
      );

  final double x;
  final double y;
  final double radius;
  final double phase;
  final double speed;
  final bool isIndigo;
}

class _MotesPainter extends CustomPainter {
  _MotesPainter(this.motes, this.clock, this.indigo, this.cyan)
      : super(repaint: clock);

  final List<_Mote> motes;
  final Animation<double> clock;
  final Color indigo;
  final Color cyan;

  @override
  void paint(Canvas canvas, Size size) {
    final t = clock.value;
    for (final m in motes) {
      final wave = 0.5 + 0.5 * sin(2 * pi * (t * m.speed * 30 + m.phase));
      final paint = Paint()
        ..color = (m.isIndigo ? indigo : cyan).withValues(alpha: 0.06 + 0.36 * wave);
      canvas.drawCircle(
        Offset(m.x * size.width, m.y * size.height),
        m.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_MotesPainter old) => false;
}
