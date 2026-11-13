import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../../providers/profile_providers.dart';
import '../../widgets/profile_widgets.dart';
import 'student_overview_tab.dart';
import 'student_academic_tab.dart';
import 'student_projects_tab.dart';
import 'student_applications_tab.dart';
import 'student_certificates_tab.dart';

class StudentTabs extends ConsumerWidget {
  const StudentTabs(this.p, {super.key});

  final StudentProfile p;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i = ref.watch(studentTabProvider);
    final l = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppDimens.md,
      children: [
        ChipBar(
          index: i,
          onChanged: ref.read(studentTabProvider.notifier).select,
          items: [
            (
              label: l.pfTabOverview,
              icon: Icons.person_outline_rounded,
              badge: null,
            ),
            (label: l.pfTabAcademic, icon: Icons.school_outlined, badge: null),
            (label: l.pfTabProjects, icon: Icons.code_rounded, badge: null),
            (
              label: l.pfTabApplications,
              icon: Icons.work_outline_rounded,
              badge: context.fmtDigits(p.applications.length),
            ),
            (
              label: l.pfTabCertificates,
              icon: Icons.workspace_premium_outlined,
              badge: null,
            ),
          ],
        ),
        PaneSwitcher(
          index: i,
          child: switch (i) {
            0 => StudentOverviewTab(p),
            1 => StudentAcademicTab(p),
            2 => StudentProjectsTab(p),
            3 => StudentApplicationsTab(p),
            _ => StudentCertificatesTab(p),
          },
        ),
      ],
    );
  }
}
