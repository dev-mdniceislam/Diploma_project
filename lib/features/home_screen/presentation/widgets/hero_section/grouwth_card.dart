import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/utils/localized_format.dart';
import 'package:diploma_job/core/widgets/animated_reveal.dart';
import 'package:diploma_job/core/widgets/custom_hover.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

// Exact tailwind shades used by the HTML graphic (not in AppColors yet).
const _rose500 = Color(0xFFF43F5E);
const _amber500 = Color(0xFFF59E0B);
const _emerald500 = Color(0xFF10B981);
const _orange300 = Color(0xFFFDBA74);

const _verifiedJobs = 1450;
const _btebPercent = 100;

/// Dark glass card on the right of the hero: window dots, chart, stats footer.
class HeroGrowthCard extends StatelessWidget {
  const HeroGrowthCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final style = AppTextStyles.bodySmall.copyWith(fontSize: 12);
    final line = Divider(
      height: 1,
      color: AppColors.darkBorder.withValues(alpha: 0.6),
    );

    return AnimatedReveal(
      child: CustomHover(
        color: Colors.transparent,
        radius: 22,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 50,
                offset: const Offset(0, 25),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.navy800.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.darkBorder.withValues(alpha: 0.6),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          spacing: 8,
                          children: [
                            _Dot(_rose500, size: 12),
                            _Dot(_amber500, size: 12),
                            _Dot(_emerald500, size: 12),
                          ],
                        ),
                        Flexible(
                          child: CustomText(
                            'BTEB Diploma Growth Matrix',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: style.copyWith(
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    line,
                    const SizedBox(height: 16),
                    const SizedBox(
                      height: 208,
                      width: double.infinity,
                      child: CustomPaint(painter: _GrowthChartPainter()),
                    ),
                    const SizedBox(height: 16),
                    line,
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 6,
                            children: [
                              const _Dot(AppColors.accentGreenLight, size: 8),
                              Flexible(
                                child: CustomText(
                                  l10n.heroVerifiedJobs(
                                    context.fmtNumber(_verifiedJobs),
                                  ),
                                  style: style.copyWith(
                                    color: AppColors.textOnDarkMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: CustomText(
                            l10n.heroBtebDiploma(
                              context.fmtPercent(_btebPercent),
                            ),
                            style: style.copyWith(
                              color: AppColors.primary400,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.color, {required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

/// Draws the HTML SVG (viewBox 400x220), scaled to fit and centered.
class _GrowthChartPainter extends CustomPainter {
  const _GrowthChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const vw = 400.0, vh = 220.0;
    final scale = math.min(size.width / vw, size.height / vh);
    canvas
      ..translate((size.width - vw * scale) / 2, (size.height - vh * scale) / 2)
      ..scale(scale);

    final fill = Paint()..style = PaintingStyle.fill;
    void bar(double x, double y, double h, Color c) => canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, 28, h),
        const Radius.circular(6),
      ),
      fill..color = c,
    );

    // background glow + bars
    canvas.drawCircle(
      const Offset(200, 110),
      85,
      fill..color = AppColors.primary600.withValues(alpha: 0.12),
    );
    bar(70, 140, 50, AppColors.primary900);
    bar(110, 110, 80, AppColors.primary700);
    bar(150, 80, 110, AppColors.primary600);
    bar(190, 50, 140, AppColors.primary500);

    // growth line + end point
    canvas.drawPath(
      Path()
        ..moveTo(70, 135)
        ..lineTo(110, 105)
        ..lineTo(150, 75)
        ..lineTo(190, 45)
        ..lineTo(270, 25),
      Paint()
        ..color = _emerald500
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(const Offset(270, 25), 6, fill..color = _emerald500);

    // diploma badge
    canvas
      ..save()
      ..translate(230, 60);
    final badge = RRect.fromRectAndRadius(
      const Rect.fromLTWH(10, 30, 80, 90),
      const Radius.circular(16),
    );
    canvas.drawRRect(badge, fill..color = AppColors.navy900);
    canvas.drawRRect(
      badge,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = AppColors.primary500,
    );
    canvas.drawPath(
      Path()
        ..moveTo(50, 35)
        ..lineTo(85, 50)
        ..lineTo(50, 65)
        ..lineTo(15, 50)
        ..close(),
      fill..color = AppColors.primary600,
    );
    canvas.drawCircle(const Offset(50, 72), 14, fill..color = _orange300);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(25, 95, 50, 12),
        const Radius.circular(6),
      ),
      fill..color = _emerald500,
    );

    final label = TextPainter(
      text: const TextSpan(
        text: 'DIPLOMA',
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    // SVG text y is the baseline
    label.paint(
      canvas,
      Offset(
        32,
        104 - label.computeDistanceToActualBaseline(TextBaseline.alphabetic),
      ),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
