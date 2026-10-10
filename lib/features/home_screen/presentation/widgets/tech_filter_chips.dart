import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/theme_pellete.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/selectable_chip.dart';
import '../../domain/entities/job.dart';
import '../providers/home_providers.dart';
import 'job_localizations.dart';

class TechFilterChips extends ConsumerWidget {
  const TechFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final selected = ref.watch(jobFilterProvider.select((f) => f.tech));
    final notifier = ref.read(jobFilterProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers_outlined, size: 16, color: context.palette.brand),
            const SizedBox(width: 6),
            Flexible(
              child: CustomText(
                l10n.techFilterTitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            SelectableChip(
              label: l10n.techAll,
              selected: selected == null,
              onTap: () => notifier.setTech(null),
            ),
            for (final tech in JobTech.values)
              SelectableChip(
                label: '${tech.emoji} ${tech.label(l10n)}',
                selected: selected == tech,
                onTap: () => notifier.setTech(tech),
              ),
          ],
        ),
      ],
    );
  }
}
