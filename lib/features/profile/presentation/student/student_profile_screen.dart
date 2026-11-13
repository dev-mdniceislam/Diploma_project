import 'package:diploma_job/features/profile/data/model/student_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile_core.dart';
import '../../providers/student_provider.dart';
import '../widgets/profile_widgets.dart';
import 'widgets/student_header.dart';
import 'widgets/student_tabs.dart';

class StudentProfileScreen extends ConsumerWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: AsyncValueView<StudentFullProfileModel>(
        value: ref.watch(studentProfileProvider),
        onRetry: () => ref.invalidate(studentProfileProvider),
        data: (p) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.md),
          child: AppContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppDimens.md,
              children: [StudentHeader(p), StudentTabs(p)],
            ),
          ),
        ),
      ),
    );
  }
}
