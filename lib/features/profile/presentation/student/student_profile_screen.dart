import 'package:diploma_job/core/responsive/responsive_container.dart';
import 'package:diploma_job/core/utils/shell_page.dart';
import 'package:diploma_job/features/profile/data/model/student_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile_core.dart';
import '../../providers/student_profile_provider/s_application_provider.dart';
import '../../providers/student_provider.dart';
import '../widgets/profile_widgets.dart';
import 'widgets/student_header.dart';
import 'widgets/student_tabs.dart';

class StudentProfileScreen extends ConsumerWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Applications are a separate request: never block the whole page on them.

    final applications =
        ref.watch(studentApplicationsProvider).value ??
        const <StudentApplicationModel>[];

    return AsyncValueView<StudentFullProfileModel>(
      value: ref.watch(studentProfileProvider),
      onRetry: () => ref.invalidate(studentProfileProvider),
      data: (p) => ShellPage(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.md),
            child: ResponsiveContainer(
              maxWidth: 1100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: AppDimens.md,
                children: [
                  StudentHeader(p, applicationsCount: applications.length),
                  StudentTabs(p, applications),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
