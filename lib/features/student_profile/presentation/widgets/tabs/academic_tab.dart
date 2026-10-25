import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../domain/entities/student_profile.dart';
import '../profile_core.dart';
import '../profile_ui.dart';

class AcademicTab extends StatelessWidget {
  const AcademicTab({super.key, required this.profile});

  final StudentProfile profile;

  @override
  Widget build(BuildContext context) {
    final ssc = profile.ssc;
    return Column(
      children: [
        ProfileCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitle(
                icon: Icons.school_outlined,
                title: context.l10n.resultBreakdown,
              ),
              const SizedBox(height: AppDimens.sm),
              _ResultsTable(profile: profile),
            ],
          ),
        ),
        if (ssc != null) ...[
          const SizedBox(height: AppDimens.md),
          _SscCard(ssc: ssc),
        ],
      ],
    );
  }
}

class _ResultsTable extends StatelessWidget {
  const _ResultsTable({required this.profile});

  final StudentProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final results = profile.semesterResults;
    final p = context.palette;
    final scale = context.fmtNumber(profile.cgpaScale, decimals: 2);

    TextStyle head() => AppTextStyles.bodySmall.copyWith(
          color: context.bodyColor,
          fontWeight: FontWeight.w700,
        );

    Widget cell(String text, {bool bold = false, Color? color}) => CustomText(
          text,
          style: AppTextStyles.bodySmall.copyWith(
            color: color ?? context.scheme.onSurface,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            fontSize: 13,
          ),
        );

    final rows = <DataRow>[
      for (final r in results)
        DataRow(
          cells: [
            DataCell(cell(context.semesterName(r.semester), bold: true)),
            DataCell(cell(context.fmtDigits(r.year))),
            DataCell(
              cell(
                '${context.fmtNumber(r.gpa, decimals: 2)} / $scale',
                bold: true,
                color: p.brand,
              ),
            ),
            DataCell(
              StatusBadge(
                label: l10n.passed,
                foreground: r.passed ? p.success : p.danger,
                background: r.passed ? p.successBg : p.dangerBg,
              ),
            ),
          ],
        ),
    ];

    if (results.isNotEmpty) {
      final firstYear = results.map((r) => r.year).reduce(math.min);
      final lastYear = results.map((r) => r.year).reduce(math.max);
      rows.add(
        DataRow(
          color: WidgetStatePropertyAll(p.pillBg),
          cells: [
            DataCell(
              cell(
                l10n.avgCgpaRange(
                  l10n.ordinal('${results.first.semester}'),
                  l10n.ordinal('${results.last.semester}'),
                ),
                bold: true,
              ),
            ),
            DataCell(
              cell(
                '${context.fmtDigits(firstYear)} - ${context.fmtDigits(lastYear)}',
                bold: true,
              ),
            ),
            DataCell(
              cell(
                '${context.fmtNumber(profile.cgpa, decimals: 2)} / $scale',
                bold: true,
                color: p.brand,
              ),
            ),
            DataCell(
              profile.cgpa >= 3.0
                  ? StatusBadge(
                      label: l10n.gradeFirstClass,
                      foreground: p.brand,
                      background: context.scheme.surface,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: constraints.maxWidth),
          child: DataTable(
            horizontalMargin: AppDimens.sm,
            columnSpacing: AppDimens.lg,
            headingRowHeight: 44,
            dataRowMinHeight: 46,
            dataRowMaxHeight: 56,
            headingRowColor: WidgetStatePropertyAll(context.mutedSurface),
            dividerThickness: 1,
            columns: [
              DataColumn(label: CustomText(l10n.colSemester, style: head())),
              DataColumn(label: CustomText(l10n.colExamYear, style: head())),
              DataColumn(label: CustomText(l10n.colGpa, style: head())),
              DataColumn(label: CustomText(l10n.colStatus, style: head())),
            ],
            rows: rows,
          ),
        ),
      ),
    );
  }
}

class _SscCard extends StatelessWidget {
  const _SscCard({required this.ssc});

  final SscRecord ssc;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTitle(
            icon: Icons.menu_book_outlined,
            title: l10n.sscTitle,
            iconColor: AppColors.urgent,
          ),
          const SizedBox(height: AppDimens.md),
          ResponsiveGrid(
            mobileColumns: 1,
            tabletColumns: 3,
            desktopColumns: 3,
            spacing: AppDimens.sm,
            children: [
              _InfoCell(label: l10n.schoolName, value: ssc.school),
              _InfoCell(
                label: l10n.groupBoard,
                value: '${ssc.group} (${ssc.board})',
              ),
              _InfoCell(
                label: l10n.passingYearGpa,
                value:
                    '${context.fmtDigits(ssc.year)} (GPA ${context.fmtNumber(ssc.gpa, decimals: 2)})',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.sm + 2),
      decoration: BoxDecoration(
        color: context.mutedSurface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: context.scheme.outline),
      ),
      child: LabeledValue(label: label, value: value),
    );
  }
}
