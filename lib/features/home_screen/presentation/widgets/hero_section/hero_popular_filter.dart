import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/features/home_screen/presentation/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// "Popular filter: #Computer #Electrical #Civil" quick chips.
class HeroPopularFilters extends ConsumerWidget {
  const HeroPopularFilters({super.key, this.alignment = WrapAlignment.start});

  final WrapAlignment alignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final notifier = ref.read(jobFilterProvider.notifier);
    final style = AppTextStyles.bodySmall.copyWith(fontSize: 12);

    // label -> value used by the technology filter (same as the HTML quickFilterFromHero)
    final tags = [
      (l10n.heroTagComputer, 'Computer'),
      (l10n.heroTagElectrical, 'Electrical'),
      (l10n.heroTagCivil, 'Civil'),
    ];

    return Wrap(
      alignment: alignment,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        CustomText(
          l10n.heroPopularFilters,
          style: style.copyWith(
            color: AppColors.textOnDarkMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        for (final (label, value) in tags)
          Material(
            color: AppColors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              hoverColor: AppColors.primary600.withValues(alpha: 0.4),
              onTap: () => notifier.setTech(value),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                child: CustomText(
                  label,
                  style: style.copyWith(color: AppColors.textOnDark),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
