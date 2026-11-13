import 'package:diploma_job/features/profile/data/model/student_profile_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../profile_core.dart';
import '../../widgets/profile_widgets.dart';

class StudentAcademicTab extends StatelessWidget {
  const StudentAcademicTab(this.p, {super.key});

  final StudentFullProfileModel p;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final palette = context.palette;
    final bold = context.tt.bodyMedium!.copyWith(
      fontWeight: FontWeight.w700,
      color: context.cs.onSurface,
    );
    final brandBold = bold.copyWith(color: palette.brand);

    String gpa(double v) =>
        '${context.fmtNumber(v, decimals: 2)} / ${context.fmtNumber(p.cgpaScale, decimals: 2)}';

    return Column(
      spacing: AppDimens.md - 4,
      children: [
        ProfileCard(
          title: l.pfResultBreakdown,
          icon: Icons.school_outlined,
          child: ProfileTable(
            columns: [l.pfSemester, l.pfExamYear, l.pfGpa, l.pfStatus],
            rows: <List<Widget>>[
              for (final r in p.semesterResults)
                [
                  CustomText(
                    l.pfSemesterN(context.fmtDigits(r.semester)),
                    style: bold,
                  ),
                  CustomText(context.fmtDigits(r.year)),
                  CustomText(gpa(r.gpa), style: brandBold),
                  StatusPill(
                    label: r.passed ? l.pfPassed : l.pfNotPassed,
                    color: r.passed ? palette.success : palette.danger,
                  ),
                ],
              if (p.semesterResults.isNotEmpty)
                [
                  CustomText(l.pfAverageCgpa, style: brandBold),
                  const SizedBox.shrink(),
                  CustomText(gpa(p.cgpaScale), style: brandBold),
                  const SizedBox.shrink(),
                ],
            ],
          ),
        ),
        if (p.ssc != null)
          ProfileCard(
            title: l.pfSscTitle,
            icon: Icons.menu_book_outlined,
            iconColor: AppColors.featured,
            child: ResponsiveWrap(
              mobile: 1,
              tablet: 3,
              desktop: 3,
              children: [
                _kv(context, l.pfSchool, p.ssc!.school),
                _kv(
                  context,
                  l.pfGroupBoard,
                  '${p.ssc!.group} / ${p.ssc!.board}',
                ),
                _kv(
                  context,
                  l.pfPassingYearGpa,
                  '${context.fmtDigits(p.ssc!.year)} / '
                  '${context.fmtNumber(p.ssc!.gpa, decimals: 2)}',
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _kv(BuildContext context, String k, String v) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        k,
        style: context.tt.bodySmall!.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textMuted,
        ),
      ),
      CustomText(
        v,
        style: context.tt.bodyMedium!.copyWith(
          fontWeight: FontWeight.w700,
          color: context.cs.onSurface,
        ),
      ),
    ],
  );
}
