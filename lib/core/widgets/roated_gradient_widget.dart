import 'dart:math' as math;

import 'package:flutter/material.dart';

/// যেকোনো widget-কে ঘিরে ঘূর্ণায়মান রঙিন gradient border ও glow দেয়।
///
/// ```dart
/// RotatingGradientBorder(
///   borderRadius: 20,
///   child: Container(
///     padding: const EdgeInsets.all(16),
///     color: Theme.of(context).colorScheme.surface,
///     child: const Text('Hello'),
///   ),
/// )
/// ```
class RotatingGradientBorder extends StatefulWidget {
  const RotatingGradientBorder({
    super.key,
    required this.child,
    this.colors = const [
      Color(0xFF6A11CB),
      Color(0xFF2575FC),
      Color(0xFF00C6FF),
      Color(0xFFFF6A88),
      Color(0xFFFFB347),
      Color(0xFF6A11CB),
    ],
    this.borderWidth = 2,
    this.borderRadius = 16,
    this.duration = const Duration(seconds: 4),
    this.glow = true,
    this.glowBlur = 14,
  });

  final Widget child;

  /// Gradient-এর রংগুলো। প্রথম ও শেষ রং একই হলে loop মসৃণ হয়।
  final List<Color> colors;

  final double borderWidth;
  final double borderRadius;

  /// এক বার পূর্ণ ঘুরতে কত সময় লাগবে।
  final Duration duration;

  final bool glow;
  final double glowBlur;

  @override
  State<RotatingGradientBorder> createState() => _RotatingGradientBorderState();
}

class _RotatingGradientBorderState extends State<RotatingGradientBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void didUpdateWidget(covariant RotatingGradientBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final innerRadius = math.max(widget.borderRadius - widget.borderWidth, 0.0);

    return AnimatedBuilder(
      animation: _controller,
      // child-টি প্রতি frame-এ rebuild হয় না, শুধু painter বদলায়
      child: Padding(
        padding: EdgeInsets.all(widget.borderWidth),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(innerRadius),
          child: widget.child,
        ),
      ),
      builder: (context, child) {
        return CustomPaint(
          painter: _GradientBorderPainter(
            progress: _controller.value,
            colors: widget.colors,
            strokeWidth: widget.borderWidth,
            radius: widget.borderRadius,
            glow: widget.glow,
            glowBlur: widget.glowBlur,
          ),
          child: child,
        );
      },
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  _GradientBorderPainter({
    required this.progress,
    required this.colors,
    required this.strokeWidth,
    required this.radius,
    required this.glow,
    required this.glowBlur,
  });

  final double progress;
  final List<Color> colors;
  final double strokeWidth;
  final double radius;
  final bool glow;
  final double glowBlur;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || strokeWidth <= 0) return;

    final rect = Offset.zero & size;
    final half = strokeWidth / 2;

    // Stroke-এর মাঝখান দিয়ে path, তাই অর্ধেক stroke বাইরে যায়
    final path = RRect.fromRectAndRadius(
      rect.deflate(half),
      Radius.circular(math.max(radius - half, 0)),
    );

    // Gradient ঘোরানো হচ্ছে progress অনুযায়ী
    final shader = SweepGradient(
      colors: colors,
      transform: GradientRotation(progress * 2 * math.pi),
    ).createShader(rect);

    if (glow) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 2
        ..shader = shader
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowBlur);
      canvas.drawRRect(path, glowPaint);
    }

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = shader
      ..isAntiAlias = true;
    canvas.drawRRect(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientBorderPainter old) {
    return old.progress != progress ||
        old.strokeWidth != strokeWidth ||
        old.radius != radius ||
        old.glow != glow ||
        old.glowBlur != glowBlur ||
        !_sameColors(old.colors, colors);
  }

  bool _sameColors(List<Color> a, List<Color> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}