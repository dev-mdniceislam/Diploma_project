import 'package:flutter/material.dart';

/// Career Orbit (HTML) daylight palette — ThemeExtension হিসেবে।
@immutable
class OrbitPalette extends ThemeExtension<OrbitPalette> {
  const OrbitPalette({
    required this.indigo,
    required this.violet,
    required this.cyan,
    required this.amber,
    required this.emerald,
    required this.rose,
    required this.ink,
    required this.inkSoft,
    required this.muted,
    required this.faint,
    required this.line,
    required this.canvas,
    required this.glassBorder,
    required this.cardBorder,
    required this.showcaseStart,
    required this.showcaseEnd,
  });

  final Color indigo;
  final Color violet;
  final Color cyan;
  final Color amber;
  final Color emerald;
  final Color rose;
  final Color ink;
  final Color inkSoft;
  final Color muted;
  final Color faint;
  final Color line;
  final Color canvas;
  final Color glassBorder;
  final Color cardBorder;
  final Color showcaseStart;
  final Color showcaseEnd;

  LinearGradient get brandGradient =>
      LinearGradient(colors: [indigo, violet, cyan]);

  LinearGradient get successGradient => LinearGradient(colors: [emerald, cyan]);

  static const light = OrbitPalette(
    indigo: Color(0xFF4F46E5),
    violet: Color(0xFF7C3AED),
    cyan: Color(0xFF0891B2),
    amber: Color(0xFFD97706),
    emerald: Color(0xFF10B981),
    rose: Color(0xFFF43F5E),
    ink: Color(0xFF0F172A),
    inkSoft: Color(0xFF475569),
    muted: Color(0xFF64748B),
    faint: Color(0xFF94A3B8),
    line: Color(0xFFE2E8F0),
    canvas: Color(0xFFF8FAFC),
    glassBorder: Color(0xF0E2E8F0),
    cardBorder: Color(0xD9C7D2FE),
    showcaseStart: Color(0xFFF4F7FF),
    showcaseEnd: Color(0xFFEEF2FF),
  );

  static OrbitPalette of(BuildContext context) =>
      Theme.of(context).extension<OrbitPalette>() ?? light;

  @override
  OrbitPalette copyWith({
    Color? indigo,
    Color? violet,
    Color? cyan,
    Color? amber,
    Color? emerald,
    Color? rose,
    Color? ink,
    Color? inkSoft,
    Color? muted,
    Color? faint,
    Color? line,
    Color? canvas,
    Color? glassBorder,
    Color? cardBorder,
    Color? showcaseStart,
    Color? showcaseEnd,
  }) {
    return OrbitPalette(
      indigo: indigo ?? this.indigo,
      violet: violet ?? this.violet,
      cyan: cyan ?? this.cyan,
      amber: amber ?? this.amber,
      emerald: emerald ?? this.emerald,
      rose: rose ?? this.rose,
      ink: ink ?? this.ink,
      inkSoft: inkSoft ?? this.inkSoft,
      muted: muted ?? this.muted,
      faint: faint ?? this.faint,
      line: line ?? this.line,
      canvas: canvas ?? this.canvas,
      glassBorder: glassBorder ?? this.glassBorder,
      cardBorder: cardBorder ?? this.cardBorder,
      showcaseStart: showcaseStart ?? this.showcaseStart,
      showcaseEnd: showcaseEnd ?? this.showcaseEnd,
    );
  }

  @override
  OrbitPalette lerp(covariant OrbitPalette? other, double t) =>
      other != null && t >= 0.5 ? other : this;
}