import 'package:diploma_job/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/open_link.dart';
import '../../../domain/entities/job_circular.dart';
import '../job_core.dart';
import '../job_ui.dart';

class JobSidebar extends StatelessWidget {
  const JobSidebar({
    super.key,
    required this.circular,
    required this.applied,
    required this.onApply,
  });

  final JobCircular circular;
  final bool applied;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: AppDimens.md);
    return Column(
      children: [
        _SummaryCard(circular: circular, applied: applied, onApply: onApply),
        gap,
        _HrCard(hr: circular.hr),
        if (circular.related.isNotEmpty) ...[
          gap,
          _RelatedCard(items: circular.related),
        ],
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.circular,
    required this.applied,
    required this.onApply,
  });

  final JobCircular circular;
  final bool applied;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = circular;
    final rows = [
      (l10n.sumPublished, context.fmtDate(c.publishedAt)),
      (l10n.sumDeadline, context.fmtDate(c.deadline)),
      (l10n.sumJobType, c.employmentType),
      (l10n.sumEducation, c.educationLabel),
      (l10n.sumHousing, c.housing),
    ];

    return JobCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(
            icon: Icons.explore_outlined,
            title: l10n.summaryTitle,
          ),
          const SizedBox(height: AppDimens.sm),
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) Divider(height: 1, color: context.scheme.outline),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    rows[i].$1,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: AppDimens.sm),
                  Expanded(
                    child: CustomText(
                      rows[i].$2,
                      textAlign: TextAlign.end,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: context.scheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppDimens.xs),
          CustomButton(
            label: applied ? l10n.applied : l10n.applyOnline,
            icon: applied
                ? Icons.check_circle_outline_rounded
                : Icons.send_rounded,
            variant: applied
                ? CustomButtonVariant.accent
                : CustomButtonVariant.primary,
            fullWidth: true,
            buttonHeight: 46,
            onPressed: onApply,
          ),
        ],
      ),
    );
  }
}

class _HrCard extends StatelessWidget {
  const _HrCard({required this.hr});

  final HrContact hr;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return JobCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(
            icon: Icons.support_agent_rounded,
            title: l10n.hrTitle,
            iconColor: AppColors.accentGreenDark,
          ),
          const SizedBox(height: AppDimens.sm + 4),
          _HrRow(
            icon: Icons.mail_outline_rounded,
            label: l10n.hrEmail,
            value: hr.email,
            onTap: () => openLink(
              context,
              'mailto:${hr.email}',
              context.l10n.linkOpenFailed,
            ),
          ),
          const SizedBox(height: AppDimens.sm),
          _HrRow(
            icon: Icons.phone_outlined,
            label: l10n.hrHelpline,
            value: context.fmtDigits(hr.phone),
          ),
          const SizedBox(height: AppDimens.sm),
          _HrRow(
            icon: Icons.public_rounded,
            label: l10n.hrWebsite,
            value: hr.websiteLabel,
            onTap: () =>
                openLink(context, hr.websiteUrl, context.l10n.linkOpenFailed),
          ),
        ],
      ),
    );
  }
}

class _HrRow extends StatelessWidget {
  const _HrRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final link = onTap != null;
    return Row(
      children: [
        IconTile(icon: icon),
        const SizedBox(width: AppDimens.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: onTap,
                child: CustomText(
                  value,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: link
                        ? context.palette.brand
                        : context.scheme.onSurface,
                    fontWeight: FontWeight.w700,
                    decoration: link ? TextDecoration.underline : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RelatedCard extends StatelessWidget {
  const _RelatedCard({required this.items});

  final List<RelatedCircular> items;

  @override
  Widget build(BuildContext context) {
    return JobCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(
            icon: Icons.layers_outlined,
            title: context.l10n.relatedTitle,
            iconColor: AppColors.featured,
          ),
          const SizedBox(height: AppDimens.sm),
          for (final item in items) ...[
            _RelatedTile(item: item),
            const SizedBox(height: AppDimens.sm),
          ],
        ],
      ),
    );
  }
}

class _RelatedTile extends StatelessWidget {
  const _RelatedTile({required this.item});

  final RelatedCircular item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      onTap: () => context.go(AppRoutes.detailsOf(item.id)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimens.sm + 2),
        decoration: BoxDecoration(
          color: context.mutedSurface,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(color: context.scheme.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              context.circularTypeLabel(item.type, item.semester),
              style: AppTextStyles.bodySmall.copyWith(
                color: context.palette.brand,
                fontWeight: FontWeight.w700,
                fontSize: 11.5,
              ),
            ),
            const SizedBox(height: 2),
            CustomText(
              item.title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: context.scheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomText(
              '${item.companyName} • ${item.location}',
              style: AppTextStyles.bodySmall.copyWith(color: context.bodyColor),
            ),
          ],
        ),
      ),
    );
  }
}
