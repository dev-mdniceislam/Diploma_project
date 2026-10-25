import 'package:flutter/material.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../domain/entities/job_circular.dart';
import '../job_core.dart';
import '../job_ui.dart';

/// Overview, responsibilities, requirements, benefits, required documents.
class JobContentCard extends StatelessWidget {
  const JobContentCard({super.key, required this.circular});

  final JobCircular circular;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = context.palette;
    final c = circular;
    const gap = SizedBox(height: AppDimens.lg);

    return JobCard(
      padding: EdgeInsets.all(
        Responsive.isDesktop(context) ? AppDimens.lg : AppDimens.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(
            icon: Icons.description_outlined,
            title: l10n.roleOverview,
            large: true,
          ),
          const SizedBox(height: AppDimens.sm),
          CustomText(
            c.overview,
            style: AppTextStyles.bodyMedium.copyWith(color: context.bodyColor),
          ),
          if (c.responsibilities.isNotEmpty) ...[
            gap,
            SectionHeading(
              icon: Icons.checklist_rounded,
              title: l10n.keyResponsibilities,
              iconColor: AppColors.accentGreenDark,
            ),
            const SizedBox(height: AppDimens.sm),
            for (final item in c.responsibilities)
              _BulletRow(text: item, icon: Icons.chevron_right_rounded),
          ],
          if (c.requirements.isNotEmpty) ...[
            gap,
            SectionHeading(
              icon: Icons.school_outlined,
              title: l10n.requirementsTitle,
            ),
            const SizedBox(height: AppDimens.sm),
            _TintedBox(
              background: context.mutedSurface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final item in c.requirements)
                    _BulletRow(text: '• $item', dense: true),
                ],
              ),
            ),
          ],
          if (c.benefits.isNotEmpty) ...[
            gap,
            SectionHeading(
              icon: Icons.card_giftcard_rounded,
              title: l10n.benefitsTitle,
              iconColor: AppColors.featured,
            ),
            const SizedBox(height: AppDimens.sm),
            ResponsiveGrid(
              mobileColumns: 1,
              tabletColumns: 2,
              desktopColumns: 2,
              spacing: AppDimens.sm,
              children: [
                for (final b in c.benefits)
                  Container(
                    padding: const EdgeInsets.all(AppDimens.sm + 2),
                    decoration: BoxDecoration(
                      color: p.successBg,
                      borderRadius: BorderRadius.circular(
                        AppDimens.radiusMd - 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 18,
                          color: p.success,
                        ),
                        const SizedBox(width: AppDimens.sm),
                        Expanded(
                          child: CustomText(
                            b,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: context.scheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
          if (c.requiredDocuments.isNotEmpty) ...[
            gap,
            SectionHeading(
              icon: Icons.error_outline_rounded,
              title: l10n.requiredDocsTitle,
              iconColor: p.tileBrown,
            ),
            const SizedBox(height: AppDimens.sm),
            _TintedBox(
              background: context.isDark
                  ? p.tileBrownBg.withValues(alpha: 0.35)
                  : p.tileBrownBg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < c.requiredDocuments.length; i++)
                    _BulletRow(
                      text:
                          '${context.fmtNumber(i + 1)}. ${c.requiredDocuments[i]}',
                      dense: true,
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TintedBox extends StatelessWidget {
  const _TintedBox({required this.child, required this.background});

  final Widget child;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.sm + 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      ),
      child: child,
    );
  }
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.text, this.icon, this.dense = false});

  final String text;
  final IconData? icon;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: dense ? 3 : 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Icon(icon, size: 16, color: context.palette.brand),
            ),
            const SizedBox(width: 6),
          ],
          Expanded(
            child: CustomText(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: context.bodyColor,
                fontSize: dense ? 13.5 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
