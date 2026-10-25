import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/gen/assets_gen.dart';
import '../../domain/entities/student_profile.dart';
import '../providers/student_profile_providers.dart';
import '../widgets/profile_core.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_tab_bar.dart';
import '../widgets/profile_ui.dart';
import '../widgets/tabs/academic_tab.dart';
import '../widgets/tabs/applications_tab.dart';
import '../widgets/tabs/certifications_tab.dart';
import '../widgets/tabs/overview_tab.dart';
import '../widgets/tabs/projects_tab.dart';

class StudentProfileScreen extends ConsumerWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(studentProfileProvider);

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _ErrorView(
        message: error is AppException
            ? error.message
            : l10n.somethingWentWrong,
        onRetry: () => ref.read(studentProfileProvider.notifier).refresh(),
      ),
      data: (p) => _ProfileBody(profile: p),
    );
  }
}

class _ProfileBody extends ConsumerWidget {
  const _ProfileBody({required this.profile});

  final StudentProfile profile;

  Widget _tabContent(ProfileTab tab) => switch (tab) {
    ProfileTab.overview => OverviewTab(profile: profile),
    ProfileTab.academic => AcademicTab(profile: profile),
    ProfileTab.projects => ProjectsTab(projects: profile.projects),
    ProfileTab.applications => const ApplicationsTab(),
    ProfileTab.certifications => CertificationsTab(profile: profile),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(profileTabProvider);

    double horizontalPadding = Responsive.value(
      context,
      mobile: 15,
      desktop: 100,
      tablet: 20,
    );

    return RefreshIndicator(
      onRefresh: () => ref.read(studentProfileProvider.notifier).refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ResponsiveContainer(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            //horizontal: 150,
            vertical: AppDimens.md,
          ),
          child: Column(
            children: [
              ProfileHeaderCard(profile: profile),
              const SizedBox(height: AppDimens.md),
              ProfileTabBar(applicationCount: profile.applications.length),
              const SizedBox(height: AppDimens.md),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOut,
                transitionBuilder: (child, anim) =>
                    FadeTransition(opacity: anim, child: child),
                child: KeyedSubtree(
                  key: ValueKey(tab),
                  child: _tabContent(tab),
                ),
              ),
              const SizedBox(height: AppDimens.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.somethingWentWrong.image(height: 160),
            const SizedBox(height: AppDimens.md),
            CustomText(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(color: context.bodyColor),
            ),
            const SizedBox(height: AppDimens.md),
            CustomButton(
              label: context.l10n.retry,
              icon: Icons.refresh_rounded,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
