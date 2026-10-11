import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';

import '../../domain/entities/auth_enums.dart';

/// Dark marketing column next to the form.
class AuthInfoPanel extends StatelessWidget {
  const AuthInfoPanel({super.key, required this.onDemo});

  final ValueChanged<UserRole> onDemo;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final features = [l10n.authFeature1, l10n.authFeature2, l10n.authFeature3];

    return Container(
      padding: EdgeInsets.all(
        Responsive.value(context, mobile: 24.0, desktop: 40.0),
      ),
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.white.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      size: 16,
                      color: AppColors.accentGreenLight,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: CustomText(
                        l10n.authBadge,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.accentGreenLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomText(
                l10n.authHeroTitle,
                style: AppTextStyles.headlineLarge
                    .responsive(context)
                    .copyWith(color: AppColors.white, height: 1.35),
              ),
              const SizedBox(height: 12),
              CustomText(
                l10n.authHeroSubtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textOnDarkMuted,
                ),
              ),
              const SizedBox(height: 24),
              for (final text in features)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.accentGreen.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: AppColors.accentGreenLight,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomText(
                          text,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textOnDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.white.withOpacity(0.12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  l10n.demoTitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textOnDarkMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    CustomButton(
                      label: l10n.demoStudent,
                      icon: Icons.person_outline_rounded,
                      variant: CustomButtonVariant.outlineOnDark,
                      buttonHeight: 38,
                      onPressed: () => onDemo(UserRole.student),
                    ),
                    CustomButton(
                      label: l10n.demoCompany,
                      icon: Icons.apartment_rounded,
                      variant: CustomButtonVariant.outlineOnDark,
                      buttonHeight: 38,
                      onPressed: () => onDemo(UserRole.company),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
