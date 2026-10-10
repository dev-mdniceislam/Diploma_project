import 'package:flutter/material.dart';

/// Centralized color palette — matched with the DiplomaJob web (Tailwind config).
/// Never hardcode colors in widgets; reference these (or ColorScheme / AppPalette).
abstract class AppColors {
  AppColors._();

  // ── Brand: primary (blue) — web: primary-* ───────────────────────────────
  static const Color primary50 = Color(0xFFEFF6FF);
  static const Color primary100 = Color(0xFFDBEAFE);
  static const Color primary200 = Color(0xFFBFDBFE);
  static const Color primary300 = Color(0xFF93C5FD);
  static const Color primary400 = Color(0xFF60A5FA);
  static const Color primary500 = Color(0xFF3B82F6);
  static const Color primary600 = Color(0xFF2563EB); // main brand
  static const Color primary700 = Color(0xFF1D4ED8); // hover / pressed
  static const Color primary800 = Color(0xFF1E40AF);
  static const Color primary900 = Color(0xFF1E3A8A);

  static const Color primary = primary600;
  static const Color primaryDark = primary700;
  static const Color primaryLight = primary500;
  static const Color primarySoft = primary50;

  // ── Navy — web: navy-* (dark header / footer / hero) ─────────────────────
  static const Color navy800 = Color(0xFF1E293B);
  static const Color navy900 = Color(0xFF0F172A);
  static const Color navy950 = Color(0xFF020617);

  // ── Semantic accents — web: urgent / success / featured ──────────────────
  static const Color urgent = Color(0xFFEA580C);
  static const Color urgentSoft = Color(0xFFFFF7ED); // orange-50
  static const Color urgentBorder = Color(0xFFFED7AA); // orange-200

  static const Color accentGreen = Color(0xFF059669); // success
  static const Color accentGreenLight = Color(0xFF34D399); // emerald-400
  static const Color accentGreenDark = Color(0xFF047857); // emerald-700
  static const Color accentGreenSoft = Color(0xFFECFDF5); // emerald-50

  static const Color featured = Color(0xFF7C3AED);
  static const Color featuredSoft = Color(0xFFF5F3FF);

  static const Color danger = Color(0xFFEF4444); // red-500
  static const Color dangerDark = Color(0xFFDC2626); // red-600
  static const Color dangerSoft = Color(0xFFFEF2F2); // red-50
  static const Color dangerBorder = Color(0xFFFECACA); // red-200

  static const Color amber = Color(0xFFEAB308); // yellow-500
  static const Color info = primary500;

  // ── Neutrals — web: slate-* ──────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8FAFC); // slate-50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF1F5F9); // slate-100
  static const Color surfaceMuted = Color(0xFFF1F5F9);
  static const Color border = Color(0xFFE2E8F0); // slate-200
  static const Color borderStrong = Color(0xFFCBD5E1); // slate-300
  static const Color textPrimary = Color(0xFF0F172A); // slate-900
  static const Color textSecondary = Color(0xFF475569); // slate-600
  static const Color textMuted = Color(0xFF94A3B8); // slate-400
  static const Color textOnDark = Color(0xFFF8FAFC);
  static const Color textOnDarkMuted = Color(0xFFCBD5E1); // slate-300

  // ── Dark theme ───────────────────────────────────────────────────────────
  static const Color darkBackground = navy950;
  static const Color darkSurface = navy900;
  static const Color darkSurfaceSecondary = navy800;
  static const Color darkBorder = Color(0xFF334155); // slate-700
  static const Color darkAccent = primary400;

  // ── Tiles (home service tiles) ───────────────────────────────────────────
  static const Color tileBlueBg = primary50;
  static const Color tileBrownBg = urgentSoft;
  static const Color tileBrown = urgent;

  // ── Gradients ────────────────────────────────────────────────────────────
  /// Web hero: bg-gradient-to-br from-slate-900 to-primary-900
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [navy900, primary900],
  );

  static const List<Color> avatarPalette = [
    primary600, // #2563EB
    primary700, // #1D4ED8
    primary900, // #1E3A8A
    navy800, // #1E293B
    accentGreen, // #059669
    urgent, // #EA580C
    featured, // #7C3AED
    accentGreenDark, // #047857
  ];

  static const List<Color> heroOverlay = [
    Color(0xCC0F172A),
    Colors.transparent,
  ];

  // ── Deprecated aliases (old names → new web-matched values) ──────────────
  static const Color primaryNavy = primary600;
  static const Color primaryNavyDark = primary700;
  static const Color primaryNavyLight = primary500;
}
