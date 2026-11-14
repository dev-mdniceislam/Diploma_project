import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extension/l10n_extension.dart';
import '../data/profile_models.dart';
import '../profile_core.dart';
import '../providers/profile_user_provider.dart';
import 'company/company_profile_screen.dart';
import 'student/student_profile_screen.dart';
import 'widgets/profile_widgets.dart';

class ProfileEntryScreen extends ConsumerStatefulWidget {
  const ProfileEntryScreen({super.key});

  @override
  ConsumerState<ProfileEntryScreen> createState() => _ProfileEntryScreenState();
}

class _ProfileEntryScreenState extends ConsumerState<ProfileEntryScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(profileUserProvider);
    final role = user.value;

    if (role == UserRole.student) return const StudentProfileScreen();
    if (role == UserRole.company) return const CompanyProfileScreen();

    // loading, error, অথবা role জানা নেই
    return Scaffold(
      body: SafeArea(
        child: AsyncValueView<UserRole?>(
          value: user,
          onRetry: () => ref.invalidate(profileUserProvider),
          data: (_) => Center(child: CustomText(context.l10n.pfUnknownRole)),
        ),
      ),
    );
  }
}

// class ProfileEntryScreen extends ConsumerWidget {
//   const ProfileEntryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(profileUserProvider);
//     final role = user.value;
//
//     if (role == UserRole.student) return const StudentProfileScreen();
//     if (role == UserRole.company) return const CompanyProfileScreen();
//
//     // loading, error, অথবা role জানা নেই
//     return Scaffold(
//       body: SafeArea(
//         child: AsyncValueView<UserRole?>(
//           value: user,
//           onRetry: () => ref.invalidate(profileUserProvider),
//           data: (_) => Center(child: CustomText(context.l10n.pfUnknownRole)),
//         ),
//       ),
//     );
//   }
// }
