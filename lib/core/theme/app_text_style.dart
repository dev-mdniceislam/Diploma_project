import 'package:flutter/material.dart';

import '../gen/fonts_gen.dart';
import '../responsive/responsive.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  AppTextStyles._();

  /// Web uses 'Noto Sans Bengali' (+ Inter fallback). Make sure
  /// FontFamily.bangla points to Noto Sans Bengali in pubspec.yaml.
  static final String _fontFamily = FontFamily.bangla;

  static TextStyle get _base => TextStyle(fontFamily: _fontFamily);

  static TextStyle get displayLarge => _base.copyWith(
    fontSize: 44,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.15,
  );

  static TextStyle get displayMedium => _base.copyWith(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get headlineLarge => _base.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static TextStyle get headlineMedium => _base.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get titleLarge => _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get titleMedium => _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyLarge => _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle get bodyMedium => _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle get bodySmall => _base.copyWith(
    fontSize: 12.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle get labelLarge => _base.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle get navLink => _base.copyWith(
    fontSize: 14.5,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// Small eyebrow label on dark hero (web: text-primary-400/300).
  static TextStyle get overline => _base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
    color: AppColors.primary400,
  );
}

/// Scales a [TextStyle]'s font size down for smaller breakpoints so
/// typography never overflows on mobile.
extension ResponsiveTextStyle on TextStyle {
  TextStyle responsive(BuildContext context) {
    final size = fontSize ?? 14;
    final device = Responsive.deviceOf(context);
    final scale = switch (device) {
      DeviceType.mobile => 0.72,
      DeviceType.tablet => 0.86,
      DeviceType.desktop => 1.0,
    };
    final scaled = size * scale;
    return copyWith(fontSize: scaled < 12 ? 12 : scaled);
  }
}
