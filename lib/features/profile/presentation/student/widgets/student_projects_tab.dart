import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../widgets/profile_widgets.dart';
import 'student_actions.dart';
import 'project_card.dart';

class StudentProjectsTab extends ConsumerWidget {
  const StudentProjectsTab(this.p, {super.key});

  final StudentProfile p;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return Column(
      spacing: AppDimens.md - 4,
      children: [
        SectionHeader(
          title: l.pfPortfolio,
          subtitle: l.pfPortfolioSub,
          trailing: CustomButton(
            label: l.pfAddProject,
            icon: Icons.add_rounded,
            onPressed: () => addStudentProject(context, ref),
          ),
        ),
        ResponsiveWrap(
          mobile: 1,
          tablet: 2,
          desktop: 2,
          children: [for (final pr in p.projects) ProjectCard(pr)],
        ),
      ],
    );
  }
}
