import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Brightness-aware colors for things ColorScheme can't express
/// (pills, status badges, service-tile accents).
/// Usage: `final p = context.palette;`
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.brand,
    required this.pillBg,
    required this.avatarBg,
    required this.success,
    required this.successBg,
    required this.danger,
    required this.dangerBg,
    required this.tileBlueBg,
    required this.tileBlue,
    required this.tileBrownBg,
    required this.tileBrown,
    required this.tileGreenBg,
    required this.tileGreen,
    required this.tileRedBg,
    required this.tileRed,
  });

  final Color brand; // logo text, location icon, links
  final Color pillBg; // location pill, logo box
  final Color avatarBg; // profile circle
  final Color success, successBg; // "embassy open" badge
  final Color danger, dangerBg; // "embassy closed" badge
  final Color tileBlueBg, tileBlue; // find probashi
  final Color tileBrownBg, tileBrown; // jobs (web: urgent/orange)
  final Color tileGreenBg, tileGreen; // local probashi
  final Color tileRedBg, tileRed; // help / SOS

  static const light = AppPalette(
    brand: AppColors.primary600,
    pillBg: AppColors.primary50,
    avatarBg: AppColors.primary600,
    success: AppColors.accentGreen,
    successBg: AppColors.accentGreenSoft,
    danger: AppColors.dangerDark,
    dangerBg: AppColors.dangerSoft,
    tileBlueBg: AppColors.primary50,
    tileBlue: AppColors.primary600,
    tileBrownBg: AppColors.urgentSoft,
    tileBrown: AppColors.urgent,
    tileGreenBg: AppColors.accentGreenSoft,
    tileGreen: AppColors.accentGreenDark,
    tileRedBg: AppColors.dangerDark,
    tileRed: AppColors.white,
  );

  static const dark = AppPalette(
    brand: AppColors.primary400,
    pillBg: AppColors.navy800,
    avatarBg: AppColors.primary500,
    success: Color(0xFF34D399),
    successBg: Color(0xFF053B2B),
    danger: Color(0xFFF87171),
    dangerBg: Color(0xFF3A1414),
    tileBlueBg: AppColors.primary800,
    tileBlue: AppColors.white,
    tileBrownBg: Color(0xFF7C2D12), // orange-900
    tileBrown: Color(0xFFFFEDD5), // orange-100
    tileGreenBg: AppColors.accentGreen,
    tileGreen: AppColors.white,
    tileRedBg: AppColors.dangerDark,
    tileRed: AppColors.white,
  );

  @override
  AppPalette copyWith({
    Color? brand,
    Color? pillBg,
    Color? avatarBg,
    Color? success,
    Color? successBg,
    Color? danger,
    Color? dangerBg,
    Color? tileBlueBg,
    Color? tileBlue,
    Color? tileBrownBg,
    Color? tileBrown,
    Color? tileGreenBg,
    Color? tileGreen,
    Color? tileRedBg,
    Color? tileRed,
  }) =>
      AppPalette(
        brand: brand ?? this.brand,
        pillBg: pillBg ?? this.pillBg,
        avatarBg: avatarBg ?? this.avatarBg,
        success: success ?? this.success,
        successBg: successBg ?? this.successBg,
        danger: danger ?? this.danger,
        dangerBg: dangerBg ?? this.dangerBg,
        tileBlueBg: tileBlueBg ?? this.tileBlueBg,
        tileBlue: tileBlue ?? this.tileBlue,
        tileBrownBg: tileBrownBg ?? this.tileBrownBg,
        tileBrown: tileBrown ?? this.tileBrown,
        tileGreenBg: tileGreenBg ?? this.tileGreenBg,
        tileGreen: tileGreen ?? this.tileGreen,
        tileRedBg: tileRedBg ?? this.tileRedBg,
        tileRed: tileRed ?? this.tileRed,
      );

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      brand: l(brand, other.brand),
      pillBg: l(pillBg, other.pillBg),
      avatarBg: l(avatarBg, other.avatarBg),
      success: l(success, other.success),
      successBg: l(successBg, other.successBg),
      danger: l(danger, other.danger),
      dangerBg: l(dangerBg, other.dangerBg),
      tileBlueBg: l(tileBlueBg, other.tileBlueBg),
      tileBlue: l(tileBlue, other.tileBlue),
      tileBrownBg: l(tileBrownBg, other.tileBrownBg),
      tileBrown: l(tileBrown, other.tileBrown),
      tileGreenBg: l(tileGreenBg, other.tileGreenBg),
      tileGreen: l(tileGreen, other.tileGreen),
      tileRedBg: l(tileRedBg, other.tileRedBg),
      tileRed: l(tileRed, other.tileRed),
    );
  }
}

extension AppPaletteX on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}