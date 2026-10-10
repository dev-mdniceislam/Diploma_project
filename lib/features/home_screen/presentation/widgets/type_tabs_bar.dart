import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/selectable_chip.dart';
import '../../domain/entities/job_filter.dart';
import '../providers/home_providers.dart';

/// All / Jobs / Attachment tabs (with live counts) + sort dropdown.
class TypeTabsBar extends ConsumerWidget {
  const TypeTabsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final filter = ref.watch(jobFilterProvider);
    final counts = ref.watch(jobCountsProvider);
    final notifier = ref.read(jobFilterProvider.notifier);

    final labels = {
      JobTypeFilter.all: l10n.tabAll(counts.all),
      JobTypeFilter.job: l10n.tabJobs(counts.jobs),
      JobTypeFilter.internship: l10n.tabInternships(counts.internships),
    };

    final tabs = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final type in JobTypeFilter.values) ...[
            SelectableChip(
              label: labels[type]!,
              selected: filter.type == type,
              selectedColor: AppColors.navy900,
              radius: 12,
              fontSize: 14,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              onTap: () => notifier.setType(type),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );

    final sort = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          l10n.sortLabel,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        AppDropdown<JobSort>(
          dense: true,
          value: filter.sort,
          items: [
            AppDropdownItem(value: JobSort.newest, label: l10n.sortNewest),
            AppDropdownItem(value: JobSort.deadline, label: l10n.sortDeadline),
          ],
          onChanged: notifier.setSort,
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: Responsive.isMobile(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(alignment: Alignment.centerLeft, child: tabs),
                const SizedBox(height: 12),
                sort,
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: tabs),
                const SizedBox(width: 16),
                sort,
              ],
            ),
    );
  }
}
