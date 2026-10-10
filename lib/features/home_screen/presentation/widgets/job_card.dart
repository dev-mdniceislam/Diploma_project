import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/theme_pellete.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_hover.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../domain/entities/job.dart';
import 'job_localizations.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.job,
    required this.isSaved,
    required this.onToggleSave,
    required this.onApply,
  });

  final Job job;
  final bool isSaved;
  final VoidCallback onToggleSave;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final palette = context.palette;
    final locale = Localizations.localeOf(context).toString();
    final isIntern = job.type == JobType.internship;

    final typeFg = isIntern ? palette.tileBrown : palette.brand;
    final typeBg = isIntern ? palette.tileBrownBg : palette.pillBg;

    return CustomHover(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(color: scheme.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ── Top: header, badges, description, tags ──
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(
                  job: job,
                  isSaved: isSaved,
                  onToggleSave: onToggleSave,
                  saveTooltip: l10n.saveCircular,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _Badge(
                      text: isIntern
                          ? l10n.jobTypeInternship
                          : l10n.jobTypeFullTime,
                      fg: typeFg,
                      bg: typeBg,
                      border: typeFg.withOpacity(0.25),
                    ),
                    _Badge(
                      text: l10n.techBadge(job.tech.label(l10n)),
                      fg: scheme.onSurface.withOpacity(0.8),
                      bg: scheme.outline.withOpacity(0.35),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CustomText(
                  job.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [for (final tag in job.tags) _Tag(tag)],
                ),
              ],
            ),

            // ── Bottom: meta + CTA ──
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                padding: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: scheme.outline)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _Meta(
                            icon: Icons.location_on_outlined,
                            text: job.location,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _Meta(
                            icon: Icons.payments_outlined,
                            text: job.salary,
                            color: palette.success,
                            bold: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: _Meta(
                            icon: Icons.schedule_rounded,
                            iconSize: 13,
                            fontSize: 11,
                            text: l10n.deadlineLabel(
                              DateFormat.yMMMd(locale).format(job.deadline),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CustomButton(
                          label: l10n.applyNow,
                          icon: Icons.arrow_forward_rounded,
                          buttonHeight: 38,
                          variant: isIntern
                              ? CustomButtonVariant.accent
                              : CustomButtonVariant.primary,
                          onPressed: onApply,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.job,
    required this.isSaved,
    required this.onToggleSave,
    required this.saveTooltip,
  });

  final Job job;
  final bool isSaved;
  final VoidCallback onToggleSave;
  final String saveTooltip;

  Color get _avatarColor {
    final sum = job.company.codeUnits.fold<int>(0, (a, b) => a + b);
    return AppColors.avatarPalette[sum % AppColors.avatarPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _avatarColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomText(
            job.company.isEmpty ? '' : job.company.characters.first,
            style: AppTextStyles.titleLarge.copyWith(color: AppColors.white),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                job.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.titleMedium.copyWith(
                  fontSize: 15,
                  color: scheme.onSurface,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(
                    Icons.business_rounded,
                    size: 14,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: CustomText(
                      job.company,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onToggleSave,
          tooltip: saveTooltip,
          padding: const EdgeInsets.all(6),
          constraints: const BoxConstraints(),
          icon: Icon(
            isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            size: 22,
            color: isSaved ? AppColors.danger : AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.text,
    required this.fg,
    required this.bg,
    this.border,
  });

  final String text;
  final Color fg;
  final Color bg;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: border == null ? null : Border.all(color: border!),
      ),
      child: CustomText(
        text,
        style: AppTextStyles.bodySmall.copyWith(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: scheme.outline.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: scheme.outline),
      ),
      child: CustomText(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({
    required this.icon,
    required this.text,
    this.color,
    this.bold = false,
    this.iconSize = 14,
    this.fontSize = 11.5,
  });

  final IconData icon;
  final String text;
  final Color? color;
  final bool bold;
  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.textSecondary;
    return Row(
      children: [
        Icon(icon, size: iconSize, color: color ?? AppColors.textMuted),
        const SizedBox(width: 4),
        Expanded(
          child: CustomText(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: fontSize,
              color: c,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
