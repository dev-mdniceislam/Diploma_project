import 'package:diploma_job/core/constants/app_dimens.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';
import 'package:diploma_job/core/utils/localized_format.dart';
import 'package:diploma_job/core/widgets/custom_hover.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/features/home_screen/presentation/widgets/job_card.dart';
import 'package:diploma_job/features/profile/data/model/company_profile_model.dart';
import 'package:diploma_job/features/profile/presentation/company/widgets/Tag.dart';
import 'package:diploma_job/features/profile/presentation/widgets/profile_theme_x.dart';
import 'package:diploma_job/features/profile/presentation/widgets/status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class JobPostingCard extends StatelessWidget {
  const JobPostingCard({
    super.key,
    required this.job,
    this.onViewApplicants,
    required this.jobCardTap,
  });

  final IndustrialJobModel job;
  final VoidCallback? onViewApplicants;
  final VoidCallback jobCardTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final tt = context.tt;
    final palette = context.palette;

    final isJob = job.jobType == JobType.job;
    final active = job.isApplicationOpen ?? false;
    // final tags = [
    //   if ((job.accommodation ?? '').isNotEmpty) job.accommodation!,
    //   ...job.tags,
    // ];

    Widget line(IconData icon, Color color, String text) => Row(
      spacing: 5,
      children: [
        Icon(icon, size: 16, color: color),
        Expanded(
          child: CustomText(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );

    final isIntern = job.jobType == JobType.internship;
    final typeFg = isIntern ? palette.tileBrown : palette.brand;
    final typeBg = isIntern ? palette.tileBrownBg : palette.pillBg;
    final l10n = context.l10n;

    return CustomHover(
      cursor: SystemMouseCursors.click,
      color: context.cs.surface,
      radius: AppDimens.radiusMd,
      child: GestureDetector(
        onTap: jobCardTap,
        child: Container(
          decoration: BoxDecoration(
            border: BoxBorder.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Flexible(child: TypePill(job.jobType)),
                  JobTypeBadge(
                    text: isIntern
                        ? l10n.jobTypeInternship
                        : l10n.jobTypeFullTime,
                    fg: typeFg,
                    bg: typeBg,
                    border: typeFg.withOpacity(0.25),
                  ),
                  if (job.vacancies != null)
                    CustomText(
                      l.pfSeats(context.fmtDigits(job.vacancies)),
                      style: tt.bodySmall!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textMuted,
                      ),
                    ),
                ],
              ),
              CustomText(
                job.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: tt.titleLarge!.copyWith(
                  color: context.cs.onSurface,
                  fontSize: 16,
                ),
              ),
              if (job.department.isNotEmpty)
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [for (final d in job.department) Tag(d)],
                ),
              // if (tags.isNotEmpty)
              //   Wrap(
              //     spacing: 8,
              //     runSpacing: 8,
              //     children: [
              //       for (final t in tags)
              //         StatusPill(label: t, color: AppColors.textSecondary),
              //     ],
              //   ),
              SizedBox(height: 3),
              Divider(
                height: 1,
                color: Theme.of(context).colorScheme.outline.withAlpha(100),
              ),
              if (job.location.isNotEmpty)
                line(
                  Icons.place_outlined,
                  AppColors.textMuted,
                  l.pfPlace(job.location),
                ),
              if (job.salary.isNotEmpty)
                line(
                  Icons.payments_outlined,
                  palette.success,
                  isJob
                      ? l.pfSalary(context.fmtDigits(job.salary))
                      : l.pfStipend(context.fmtDigits(job.salary)),
                ),
              if (job.deadline != null)
                line(
                  Icons.schedule_rounded,
                  AppColors.urgent,
                  l.pfDeadline(context.fmtDate(job.deadline!)),
                ),
              if (onViewApplicants != null || active) ...[
                Divider(
                  height: 1,
                  color: Theme.of(context).colorScheme.outline.withAlpha(100),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (onViewApplicants != null)
                      TextButton.icon(
                        onPressed: onViewApplicants,
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          foregroundColor: palette.brand,
                          textStyle: tt.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        icon: const Icon(
                          Icons.people_outline_rounded,
                          size: 16,
                        ),
                        label: Text(
                          l.pfViewApplicants(
                            context.fmtDigits(job.applicantCount ?? 0),
                          ),
                          style: AppTextStyles.titleMedium.copyWith(
                            fontSize: 13,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    if (active)
                      StatusPill(label: l.pfActive, color: palette.success),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
