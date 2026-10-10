import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';

/// Centers content and caps its width (web: `max-w-7xl mx-auto px-*`).
class AppContainer extends StatelessWidget {
  const AppContainer({super.key, required this.child, this.maxWidth = 1280});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.value(
      context,
      mobile: 16.0,
      desktop: 32.0,
      tablet: 24.00,
    );
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          child: child,
        ),
      ),
    );
  }
}
