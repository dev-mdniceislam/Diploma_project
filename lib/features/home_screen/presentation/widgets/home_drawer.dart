import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/theme_pellete.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/entities/job_filter.dart';
import '../providers/home_providers.dart';
import 'home_callbacks.dart';
import 'persona_switcher.dart';

/// Mobile / tablet menu (replaces the HTML hamburger dropdown).
class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key, required this.callbacks});

  final HomeCallbacks callbacks;

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
                onTap: () => run(() => notifier.setType(JobTypeFilter.all)),
              ),
              _DrawerItem(
                icon: Icons.school_outlined,
                label: l10n.navAttachment,
                onTap: () =>
                    run(() => notifier.setType(JobTypeFilter.internship)),
              ),
              _DrawerItem(
                icon: Icons.menu_book_outlined,
                label: l10n.navGuide,
                onTap: () => run(callbacks.onOpenGuide),
              ),
              const Spacer(),
              CustomButton(
                label: l10n.postCircular,
                icon: Icons.add_circle_outline_rounded,
                variant: CustomButtonVariant.accent,
                fullWidth: true,
                buttonHeight: 48,
                onPressed: () => run(callbacks.onPostCircular),
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
