import 'package:diploma_job/core/theme/orbit_palette.dart';
import 'package:flutter/material.dart';

/// Tailwind `animate-ping` এর Flutter version।
class PingDot extends StatefulWidget {
  const PingDot({
    super.key,
    this.size = 8,
    this.color,
    this.solid = true,
  });

  final double size;
  final Color? color;
  final bool solid;

  @override
  State<PingDot> createState() => _PingDotState();
}

class _PingDotState extends State<PingDot> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? OrbitPalette.of(context).emerald;
    final dot = Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );

    return SizedBox.square(
      dimension: widget.size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          AnimatedBuilder(
            animation: _c,
            builder: (_, child) => Opacity(
              opacity: (1 - _c.value) * (widget.solid ? 0.75 : 1),
              child: Transform.scale(scale: 1 + _c.value, child: child),
            ),
            child: dot,
          ),
          if (widget.solid) dot,
        ],
      ),
    );
  }
}
