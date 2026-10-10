import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';

import '../extension/l10n_extension.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';
import '../theme/theme_pellete.dart';
import 'custom_text.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n!;
    final size = compact ? 32.0 : 48.0;

    final mark = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [AppColors.primary600, AppColors.accentGreen],
        ),
        borderRadius: BorderRadius.circular(compact ? 8 : 12),
        boxShadow: compact
            ? null
            : [
                BoxShadow(
                  color: AppColors.primary500.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Icon(
        Icons.work_outline_rounded,
        color: AppColors.white,
        size: compact ? 16 : 24,
      ),
    );

    if (compact) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          mark,
          const SizedBox(width: 8),
          CustomText(
            l10n.appName,
            style: AppTextStyles.titleLarge.copyWith(color: AppColors.white),
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => LinearGradient(
                  colors: [context.palette.brand, AppColors.accentGreen],
                ).createShader(bounds),
                child: CustomText(
                  l10n.appName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.white,
                    height: 1.2,
                  ),
                ),
              ),
              if (Responsive.isMobile(context))
                CustomText(
                  l10n.appTagline,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 11.5,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
