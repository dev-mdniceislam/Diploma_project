import 'package:diploma_job/core/router/app_router.dart';
import 'package:diploma_job/features/home_screen/domain/entities/job_filter.dart';
import 'package:diploma_job/features/splash/presentation/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/theme_pellete.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_hover.dart';
import '../../../../core/widgets/custom_text.dart';

/// API-তে jobType এর মান: 'industrial-attachment' ইত্যাদি।
const _internshipType = 'industrial-attachment';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.job,
    this.isSaved,
    this.onToggleSave,
    this.onApply,
  });

  final JobListItem job;
  final bool? isSaved;
  final VoidCallback? onToggleSave;
  final VoidCallback? onApply;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final palette = context.palette;
    final locale = Localizations.localeOf(context).toString();
    final isIntern = job.jobType == _internshipType;

    final typeFg = isIntern ? palette.tileBrown : palette.brand;
    final typeBg = isIntern ? palette.tileBrownBg : palette.pillBg;

    return CustomHover(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.push(AppRoutes.detailsOf(job.id)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            border: Border.all(color: scheme.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // ── Top: header + badge ──
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(
                    job: job,
                    isSaved: isSaved ?? false,
                    onToggleSave: onToggleSave ?? () {},
                    saveTooltip: l10n.saveCircular,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      JobTypeBadge(
                        text: isIntern
                            ? l10n.jobTypeInternship
                            : l10n.jobTypeFullTime,
                        fg: typeFg,
                        bg: typeBg,
                        border: typeFg.withValues(alpha: 0.25),
                      ),
                      if (job.departments.isNotEmpty)
                        ...job.departments.map(
                          (dept) => JobTypeBadge(
                            text: dept,
                            fg: palette.brand,
                            bg: palette.pillBg,
                            border: palette.brand.withValues(alpha: 0.2),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (job.description.isNotEmpty)
                    CustomText(
                      job.description,
                      style: AppTextStyles.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),

              // ── Bottom: meta + CTA ──
              Padding(
                padding: const EdgeInsets.only(top: 20),
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
                          if (job.stipend > 0) ...[
                            const SizedBox(width: 8),
                            Expanded(
                              child: _Meta(
                                icon: Icons.payments_outlined,
                                text: '৳${job.stipend}',
                                color: palette.success,
                                bold: true,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: job.deadline == null
                                ? const SizedBox.shrink()
                                : _Meta(
                                    icon: Icons.schedule_rounded,
                                    iconSize: 13,
                                    fontSize: 11,
                                    text: l10n.deadlineLabel(
                                      DateFormat.yMMMd(locale)
                                          .format(job.deadline!),
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 8),
                          Consumer(
                            builder: (context, ref, child) {
                              final profile = ref
                                  .watch(userProfileProvider)
                                  .value;

                              if (profile?.isStudent == true) {
                                return CustomButton(
                                  label: l10n.applyNow,
                                  icon: Icons.arrow_forward_rounded,
                                  buttonHeight: 38,
                                  variant: isIntern
                                      ? CustomButtonVariant.accent
                                      : CustomButtonVariant.primary,
                                  onPressed: onApply,
                                );
                              }

                              return const SizedBox.shrink();
                            },
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

  final JobListItem job;
  final bool isSaved;
  final VoidCallback onToggleSave;
  final String saveTooltip;

  Color get _avatarColor {
    final sum = job.companyName.codeUnits.fold<int>(0, (a, b) => a + b);
    return AppColors.avatarPalette[sum % AppColors.avatarPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final initial = job.companyName.isEmpty
        ? ''
        : job.companyName.substring(0, 1);

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
            initial,
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
              if (job.companyName.isNotEmpty) ...[
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
                        job.companyName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (job.isVerified) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, size: 14, color: Colors.blue),
                    ],
                  ],
                ),
              ],
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

class JobTypeBadge extends StatelessWidget {
  const JobTypeBadge({
    super.key,
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
            maxLines: 1,
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
