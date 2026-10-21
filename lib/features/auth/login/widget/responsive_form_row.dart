import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';

/// Side-by-side fields on wide screens, stacked on narrow ones.
/// LayoutBuilder use kora jabe na, karon AuthPage e IntrinsicHeight ache.
class ResponsiveFormRow extends StatelessWidget {
  const ResponsiveFormRow({
    super.key,
    required this.children,
    this.spacing = 16,
  });

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // Desktop e form ta panel er pashe thake (shoru), tai onek chwto.
    // Tablet e form full width pay.
    final isWide = Responsive.isDesktopWidth(width)
        ? width >= 1180
        : width >= 700;

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(width: spacing),
            Expanded(child: children[i]),
          ],
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) SizedBox(height: spacing),
          children[i],
        ],
      ],
    );
  }
}
