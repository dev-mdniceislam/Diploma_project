import 'package:flutter/material.dart';

import '../../profile_core.dart';

/// 2/3 + 1/3 on desktop, stacked on mobile and tablet.
class TwoColumn extends StatelessWidget {
  const TwoColumn({super.key, required this.main, required this.side});

  final List<Widget> main, side;

  @override
  Widget build(BuildContext context) {
    Widget stacked(BuildContext _) => Column(
          spacing: AppDimens.md - 4,
          children: [...main, ...side],
        );
    return ResponsiveBuilder(
      mobile: stacked,
      tablet: stacked,
      desktop: (_) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimens.md,
        children: [
          Expanded(flex: 2, child: Column(spacing: AppDimens.md - 4, children: main)),
          Expanded(child: Column(spacing: AppDimens.md - 4, children: side)),
        ],
      ),
    );
  }
}
