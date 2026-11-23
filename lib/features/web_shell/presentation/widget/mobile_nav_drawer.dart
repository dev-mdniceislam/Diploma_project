import 'package:diploma_job/core/database/local_storage.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/features/splash/presentation/provider/user_profile_provider.dart';
import 'package:diploma_job/features/web_shell/presentation/widget/cta_button.dart';
import 'package:diploma_job/features/web_shell/presentation/widget/logout_dialogue.dart';
import 'package:diploma_job/features/web_shell/presentation/widget/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../home_screen/domain/entities/job_filter.dart';
import '../../../home_screen/presentation/providers/home_providers.dart';
import 'navbar/main_navbar.dart';

/// Mobile / tablet menu. Login অবস্থা অনুযায়ী section ও action দেখায়।
class MobileNavDrawer extends ConsumerWidget {
  const MobileNavDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final notifier = ref.read(jobFilterProvider.notifier);
    final profile = ref.watch(userProfileProvider).value;
    final router = GoRouter.of(context);
    final navigator = Navigator.of(context);

    final isCompany = profile?.isCompany ?? false;
    debugPrint('=================================profile=${profile?.role} isCompany=$isCompany');

    // drawer বন্ধ করে action চালায়। context ব্যবহার না করে আগে ধরা router/navigator ব্যবহার হয়।
    void run(VoidCallback action) {
      navigator.pop();
      action();
    }

    Future<void> logout(BuildContext context) async {
      final confirmed = await showLogoutDialog(context, name: profile?.name);
      if (!confirmed || !context.mounted) return;

      await LocalStorage().deleteAllData();
      ref.invalidate(userProfileProvider);

      if (navigator.canPop()) navigator.pop(); // drawer বন্ধ
      router.go(AppRoutes.auth);
    }

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── User info (student) ───────────────────────────────────
                if (profile != null && !isCompany) ...[
                  _SectionHeader(label: profile.role),
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () => run(() {
                      router.go(AppRoutes.profile);
                    }),
                    child: Row(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileAvatar(
                          imagePath: profile.profile,
                          ontap: () => run(() {
                            router.go(AppRoutes.profile);
                          }),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                profile.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              CustomText(
                                profile.id,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontSize: 12,
                                  color: AppColors.darkAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 5),
                Divider(color: Theme.of(context).colorScheme.outline),

                // ── Main navigation ───────────────────────────────────────
                _DrawerItem(
                  icon: Icons.home_rounded,
                  label: l10n.navHome,
                  onTap: () => run(() {
                    notifier.setType(JobTypeFilter.all);
                    router.go(AppRoutes.home);
                  }),
                ),
                _DrawerItem(
                  icon: Icons.article_outlined,
                  label: l10n.navNotice,
                  onTap: () => run(() => router.go(NavPaths.notice)),
                ),
                _DrawerItem(
                  icon: Icons.menu_book_outlined,
                  label: l10n.navGuide,
                  onTap: () => run(() => router.go(AppRoutes.guide)),
                ),
                _DrawerItem(
                  icon: Icons.bookmark_outline,
                  label: l10n.bookmarkButton,
                  onTap: () => run(() => router.go(NavPaths.companies)),
                ),
                _DrawerItem(
                  icon: Icons.apartment_outlined,
                  label: l10n.navCompanies,
                  onTap: () => run(() => router.go(AppRoutes.saved)),
                ),
                _DrawerItem(
                  icon: Icons.info_outline_rounded,
                  label: l10n.navAbout,
                  onTap: () => run(() => router.go(NavPaths.about)),
                ),

                const SizedBox(height: 5),
                Divider(color: Theme.of(context).colorScheme.outline),
                const SizedBox(height: 10),

                // ── Login / Logout ────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: profile == null
                          ? CtaButton(
                              label: l10n.loginAction,
                              icon: Icons.login_rounded,
                              height: 40,
                              borderRadius: 5,
                              onPressed: () =>
                                  run(() => router.go(NavPaths.login)),
                            )
                          : CtaButton(
                              label: l10n.logout,
                              icon: Icons.logout_rounded,
                              height: 40,
                              borderRadius: 5,
                              onPressed: () => logout(context),
                            ),
                    ),
                  ],
                ),
              ],
            ),
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
      padding: const EdgeInsets.only(left: 8, top: 12, bottom: 4),
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
