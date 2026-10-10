import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Wraps [child] and fades/slides it in the first time it becomes visible
/// while scrolling. Deliberately one-shot (no repeated re-triggering) so
/// the page doesn't feel jittery on scroll-back.
class AnimatedReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double offsetY;

  const AnimatedReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offsetY = 24,
  });

  @override
  State<AnimatedReveal> createState() => _AnimatedRevealState();
}

class _AnimatedRevealState extends State<AnimatedReveal> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget.hashCode),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.12 && !_visible) {
          Future.delayed(widget.delay, () {
            if (mounted) setState(() => _visible = true);
          });
        }
      },
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _visible ? Offset.zero : Offset(0, widget.offsetY / 100),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
