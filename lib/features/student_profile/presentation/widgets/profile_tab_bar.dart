import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../providers/student_profile_providers.dart';
import 'profile_core.dart';
import 'profile_ui.dart';

extension ProfileTabX on ProfileTab {
  IconData get icon => switch (this) {
    ProfileTab.overview => Icons.person_outline_rounded,
    ProfileTab.academic => Icons.school_outlined,
    ProfileTab.projects => Icons.code_rounded,
    ProfileTab.applications => Icons.work_outline_rounded,
    ProfileTab.certifications => Icons.workspace_premium_outlined,
  };

  String label(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      ProfileTab.overview => l10n.tabOverview,
      ProfileTab.academic => l10n.tabAcademic,
      ProfileTab.projects => l10n.tabProjects,
      ProfileTab.applications => l10n.tabApplications,
      ProfileTab.certifications => l10n.tabCertifications,
    };
  }
}

class ProfileTabBar extends ConsumerWidget {
  const ProfileTabBar({super.key, required this.applicationCount});

  final int applicationCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(profileTabProvider);

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.scheme.outline)),
      ),
      padding: const EdgeInsets.only(bottom: AppDimens.sm),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final tab in ProfileTab.values) ...[
              _TabChip(
                tab: tab,
                selected: tab == selected,
                badge: tab == ProfileTab.applications ? applicationCount : null,
                onTap: () => ref.read(profileTabProvider.notifier).select(tab),
              ),
              const SizedBox(width: AppDimens.xs + 2),
            ],
          ],
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.tab,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final ProfileTab tab;
  final bool selected;
  final int? badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? context.scheme.onPrimary : context.bodyColor;

    return Material(
      color: selected ? context.scheme.primary : context.scheme.surface,
      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.sm + 4,
            vertical: AppDimens.sm,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            border: Border.all(
              color: selected ? Colors.transparent : context.scheme.outline,
            ),
          ),
          child: Row(
            children: [
              Icon(tab.icon, size: 17, color: fg),
              const SizedBox(width: 6),
              CustomText(
                tab.label(context),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (badge != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.amber.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomText(
                    context.fmtNumber(badge!),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: selected ? Colors.white : AppColors.urgent,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
