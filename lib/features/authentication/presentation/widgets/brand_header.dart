import 'package:diploma_job/core/constants/app_dimens.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/orbit_palette.dart';
import 'package:flutter/material.dart';

import 'gradient_text.dart';
import 'orbit_logo.dart';
import 'ping_dot.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);
    final showPill = MediaQuery.sizeOf(context).width >= AppDimens.mobileMax;
    final titleStyle = AppTextStyles.headlineMedium.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      color: p.ink,
    );

    return Row(
      children: [
        const OrbitLogo(),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                TextSpan(
                  style: titleStyle,
                  children: [
                    const TextSpan(text: 'Career'),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: GradientText(
                        'Orbit',
                        gradient: p.brandGradient,
                        style: titleStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                l10n.brandSubtitle.toUpperCase(),
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                  color: p.muted,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        if (showPill) _LivePill(text: l10n.livePill),
      ],
    );
  }
}

class _LivePill extends StatelessWidget {
  const _LivePill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: p.line),
        boxShadow: [
          BoxShadow(
            color: p.ink.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PingDot(size: 8),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: p.inkSoft,
            ),
          ),
        ],
      ),
    );
  }
}
