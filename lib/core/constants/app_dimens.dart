class AppDimens {
  AppDimens._();

  // Breakpoints (Logical px width)
  static const double mobileMax = 600;
  static const double tabletMax = 1024;
  static const double desktopMax = 1440;
  static const double contentMaxWidth = 1180;

  // Spacing Scale
  static const double xs = 6;
  static const double sm = 12;
  static const double md = 20;
  static const double lg = 32;
  static const double xl = 56;
  static const double xxl = 96;



  // Border Radius
  static const double radiusSm = 6;
  static const double radiusMd = 12;
  static const double radiusLg = 20;

  // Responsive Section Padding
  static double sectionPaddingV(double width) {
    if (width < mobileMax) return 56;
    if (width < tabletMax) return 72;
    return 96;
  }

  // Responsive Horizontal Gutter
  static double horizontalGutter(double width) {
    if (width < mobileMax) return 20;
    if (width < tabletMax) return 40;
    return 72;
  }
}