import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (Responsive.isDesktopWidth(width)) return desktop(context);
        if (Responsive.isTabletWidth(width)) {
          return (tablet ?? desktop)(context);
        }
        return mobile(context);
      },
    );
  }
}
