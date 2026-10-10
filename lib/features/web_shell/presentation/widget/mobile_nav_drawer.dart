import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';
import 'package:diploma_job/core/widgets/app_logo.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../home_screen/domain/entities/job_filter.dart';
import '../../../home_screen/presentation/providers/home_providers.dart';
import '../../../home_screen/presentation/widgets/persona_switcher.dart';

/// Mobile / tablet menu (replaces the HTML hamburger dropdown).
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
              const PersonaSwitcher(expanded: true),
              const SizedBox(height: 12),
              _DrawerItem(
                icon: Icons.grid_view_rounded,
                label: l10n.navHome,
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
                icon: Icons.menu_book_outlined,
                label: l10n.navGuide,
                onTap: () => run(() => context.go(AppRoutes.guide)),
              ),
              const Spacer(),
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
      title: Text(
        label,
        style: AppTextStyles.navLink.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      onTap: onTap,
    );
  }
}
