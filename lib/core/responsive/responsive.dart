import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

/// Central breakpoint definitions + helpers. Every responsive decision in
/// the app should route through here rather than ad-hoc MediaQuery checks,
/// so breakpoints stay consistent across the whole site.
abstract class Responsive {
  Responsive._();

  static const double mobileMax = 599;
  static const double tabletMax = 1023;
  static const double maxContentWidth = 1240;

  /// Width (double) ভিত্তিক DeviceType নির্ণয় (LayoutBuilder constraints-এর জন্য)
  static DeviceType deviceTypeOfWidth(double width) {
    if (width <= mobileMax) return DeviceType.mobile;
    if (width <= tabletMax) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  /// BuildContext ভিত্তিক DeviceType নির্ণয়
  static DeviceType deviceOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return deviceTypeOfWidth(width);
  }

  // Width (double) ভিত্তিক হেলপারস
  static bool isMobileWidth(double width) =>
      deviceTypeOfWidth(width) == DeviceType.mobile;

  static bool isTabletWidth(double width) =>
      deviceTypeOfWidth(width) == DeviceType.tablet;

  static bool isDesktopWidth(double width) =>
      deviceTypeOfWidth(width) == DeviceType.desktop;

  // BuildContext ভিত্তিক হেলপারস
  static bool isMobile(BuildContext context) =>
      deviceOf(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      deviceOf(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      deviceOf(context) == DeviceType.desktop;

  /// Picks a value based on current breakpoint, falling back gracefully
  /// (desktop -> tablet -> mobile) if a given breakpoint isn't supplied.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    final device = deviceOf(context);
    switch (device) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? desktop;
      case DeviceType.desktop:
        return desktop;
    }
  }

  /// Horizontal page padding that grows with screen size.
  static double horizontalPadding(BuildContext context) => value(
        context,
        mobile: 15,
        tablet: 15,
        desktop: 35,
      );

  /// Number of grid columns for card grids across the site.
  static int gridColumns(BuildContext context, {int desktopMax = 4}) => value(
        context,
        mobile: 1,
        tablet: 2,
        desktop: desktopMax,
      );
}
