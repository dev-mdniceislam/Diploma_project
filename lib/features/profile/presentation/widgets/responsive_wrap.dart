import 'package:flutter/material.dart';

import '../../profile_core.dart';

/// Wraps children into N equal columns (N from the app's breakpoints).
class ResponsiveWrap extends StatelessWidget {
  const ResponsiveWrap({
    super.key,
    required this.children,
    this.mobile = 1,
    this.tablet = 2,
    this.desktop = 3,
    this.gap = AppDimens.md - 4,
  });

  final List<Widget> children;
  final int mobile, tablet, desktop;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final cols = Responsive.value(context, mobile: mobile, tablet: tablet, desktop: desktop);
    return LayoutBuilder(
      builder: (_, c) {
        final w = ((c.maxWidth - gap * (cols - 1)) / cols).floorToDouble();
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [for (final child in children) SizedBox(width: w, child: child)],
        );
      },
    );
  }
}
