import 'package:flutter/material.dart';
import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_text.dart';

class HeroStats extends StatelessWidget {
  const HeroStats({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = [
      (l10n.statJobsValue, l10n.statJobsLabel, AppColors.accentGreenLight),
      (l10n.statInternsValue, l10n.statInternsLabel, AppColors.amber),
      (l10n.statPartnersValue, l10n.statPartnersLabel, AppColors.primary300),
      (l10n.statPolytechnicValue, l10n.statPolytechnicLabel, AppColors.textOnDark),
    ];

    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.white.withOpacity(0.1))),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 16.0;
          final columns = constraints.maxWidth < 560 ? 2 : 4;
          final itemWidth =
              (constraints.maxWidth - spacing * (columns - 1)) / columns;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            alignment: WrapAlignment.center,
            children: [
              for (final (value, label, color) in items)
                SizedBox(
                  width: itemWidth,
                  child: Column(
                    children: [
                      CustomText(
                        value,
                        style: AppTextStyles.headlineMedium
                            .copyWith(color: color, fontSize: 24),
                      ),
                      const SizedBox(height: 2),
                      CustomText(
                        label,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textMuted,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
