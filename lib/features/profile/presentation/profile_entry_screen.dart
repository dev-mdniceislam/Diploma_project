import 'package:diploma_job/features/splash/presentation/provider/user_profile_provider.dart';
import 'package:diploma_job/shared/shimmer/profile/profile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extension/l10n_extension.dart';
import '../profile_core.dart';
import 'company/company_profile_screen.dart';
import 'student/student_profile_screen.dart';
import 'widgets/profile_widgets.dart';

class ProfileEntryScreen extends ConsumerWidget {
  const ProfileEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userProfileProvider);
    final user = asyncUser.value; // loading বা error হলে null

    // Role জানা গেলে সংশ্লিষ্ট screen
    if (user?.isStudent == true) return const StudentProfileScreen();
    if (user?.isCompany == true) return const CompanyProfileScreen();

    // Loading: skeleton | Error: retry | Role নেই: বার্তা
    return Scaffold(
      body: SafeArea(
        child: AsyncValueView(
          value: asyncUser,
          loadingBuilder: (_) => const ProfileShimmerPage(),
          onRetry: () => ref.invalidate(userProfileProvider),
          data: (_) => Center(child: CustomText(context.l10n.pfUnknownRole)),
        ),
      ),
    );
  }
}
