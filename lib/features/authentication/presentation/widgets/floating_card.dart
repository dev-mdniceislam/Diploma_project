import 'package:flutter/material.dart';

/// `animate-float-*` (translateY 0 → -9px → 0) এর Flutter version।
class FloatingCard extends StatefulWidget {
  const FloatingCard({
    super.key,
    required this.child,
    required this.period,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration period;
  final Duration delay;

  @override
  State<FloatingCard> createState() => _FloatingCardState();
}

class _FloatingCardState extends State<FloatingCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: widget.period ~/ 2,
  );

  late final Animation<double> _offset = Tween<double>(begin: 0, end: -9)
      .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _c.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _offset,
        builder: (_, child) =>
            Transform.translate(offset: Offset(0, _offset.value), child: child),
        child: widget.child,
      );
}
