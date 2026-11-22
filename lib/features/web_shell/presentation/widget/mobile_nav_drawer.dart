import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';
import 'package:diploma_job/core/widgets/app_logo.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../home_screen/domain/entities/job_filter.dart';
import '../../../home_screen/presentation/providers/home_providers.dart';
import '../../../home_screen/presentation/widgets/persona_switcher.dart';
import 'navbar/main_navbar.dart';

/// Mobile / tablet menu. Navbar-এর সব link এখানে আছে।
class MobileNavDrawer extends ConsumerWidget {
  const MobileNavDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final notifier = ref.read(jobFilterProvider.notifier);

    void run(VoidCallback action) {
      Navigator.of(context).pop();
      action();
    }

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(alignment: Alignment.centerLeft, child: AppLogo()),
              const SizedBox(height: 20),

              // ── Main navigation ───────────────────────────────────────
              _DrawerItem(
                icon: Icons.home_rounded,
                label: l10n.navHome,
                onTap: () => run(() {
                  notifier.setType(JobTypeFilter.all);
                  context.go(AppRoutes.home);
                }),
              ),
              _DrawerItem(
                icon: Icons.work_outline_rounded,
                label: l10n.navAllJobs,
                onTap: () => run(() {
                  notifier.setType(JobTypeFilter.all);
                  context.go(AppRoutes.home);
                }),
              ),
              _DrawerItem(
                icon: Icons.school_outlined,
                label: l10n.navAttachment,
                onTap: () => run(() {
                  notifier.setType(JobTypeFilter.internship);
                  context.go(AppRoutes.home);
                }),
              ),
              _DrawerItem(
                icon: Icons.article_outlined,
                label: l10n.navNotice,
                onTap: () => run(() => context.go(NavPaths.notice)),
              ),
              _DrawerItem(
                icon: Icons.menu_book_outlined,
                label: l10n.navGuide,
                onTap: () => run(() => context.go(AppRoutes.guide)),
              ),
              _DrawerItem(
                icon: Icons.apartment_outlined,
                label: l10n.navCompanies,
                onTap: () => run(() => context.go(NavPaths.companies)),
              ),
              _DrawerItem(
                icon: Icons.info_outline_rounded,
                label: l10n.navAbout,
                onTap: () => run(() => context.go(NavPaths.about)),
              ),

              const SizedBox(height: 12),
              Divider(color: Theme.of(context).colorScheme.outline),
              const SizedBox(height: 8),

              // ── Persona ───────────────────────────────────────────────
              const PersonaSwitcher(expanded: true),
              const SizedBox(height: 12),

              // ── Student section ───────────────────────────────────────
              _SectionHeader(label: l10n.personaStudent),
              _DrawerItem(
                icon: Icons.person_outline_rounded,
                label: l10n.navMyProfile,
                onTap: () => run(() => context.go(AppRoutes.profile)),
              ),

              const SizedBox(height: 12),

              // ── Company section ───────────────────────────────────────
              _SectionHeader(label: l10n.personaCompany),
              _DrawerItem(
                icon: Icons.add_business_outlined,
                label: l10n.navPostAJob,
                onTap: () => run(() => context.go(AppRoutes.postCircular)),
              ),

              const Spacer(),

              // ── Actions ───────────────────────────────────────────────
              CustomButton(
                label: l10n.loginAction,
                icon: Icons.login_rounded,
                variant: CustomButtonVariant.primary,
                fullWidth: true,
                buttonHeight: 48,
                onPressed: () => run(() => context.go(NavPaths.login)),
              ),
              const SizedBox(height: 8),
              CustomButton(
                label: l10n.postCircular,
                icon: Icons.add_circle_outline_rounded,
                variant: CustomButtonVariant.accent,
                fullWidth: true,
                buttonHeight: 48,
                onPressed: () => run(() => context.go(AppRoutes.postCircular)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: CustomText(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: Icon(icon, size: 20, color: context.palette.brand),
      title: CustomText(
        label,
        style: AppTextStyles.navLink.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      onTap: onTap,
    );
  }
}
