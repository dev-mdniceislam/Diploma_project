import 'package:diploma_job/core/gen/assets_gen.dart';
import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';

import '../extension/l10n_extension.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';
import 'custom_text.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final mark = Assets.images.appLogo.image(
      height: 55,
      width: 55,
      color: compact ? AppColors.white : AppColors.primary,
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

    final isMobile = Responsive.isMobile(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        const SizedBox(width: 5),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: CustomText(
                      'Career',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.headlineMedium
                          .responsive(context)
                          .copyWith(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  Flexible(
                    child: CustomText(
                      'Orbit',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.headlineMedium
                          .responsive(context)
                          .copyWith(
                            color: AppColors.primary,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primary100,
                    ),
                    child: CustomText(
                      'BD',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (!isMobile)
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
