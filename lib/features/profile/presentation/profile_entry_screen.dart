import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extension/l10n_extension.dart';
import '../data/profile_models.dart';
import '../profile_core.dart';
import '../providers/profile_providers.dart';
import 'company/company_profile_screen.dart';
import 'student/student_profile_screen.dart';
import 'widgets/profile_widgets.dart';

/// `/profile` lands here. Fetches the profile once, then shows the screen that
/// matches `data.role` ("student" | "company").
class ProfileEntryScreen extends ConsumerWidget {
  const ProfileEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileUserProvider);

    switch (user.value?.role) {
      case UserRole.student:
        return const StudentProfileScreen();
      case UserRole.company:
        return const CompanyProfileScreen();
      default:
        // loading, error, or an unsupported role
        return Scaffold(
          body: SafeArea(
            child: AsyncValueView<ProfileUser>(
              value: user,
              onRetry: () => ref.invalidate(profileUserProvider),
              data: (_) =>
                  Center(child: CustomText(context.l10n.pfUnknownRole)),
            ),
          ),
        );
    }
  }
}
