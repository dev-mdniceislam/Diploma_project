import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/theme_pellete.dart';
import '../../../../core/widgets/custom_overlay_notification.dart';
import '../providers/home_providers.dart';

/// Student / Company segmented switch.
class PersonaSwitcher extends ConsumerWidget {
  const PersonaSwitcher({super.key, this.expanded = false});

  /// Fill the available width (used in the mobile drawer).
  final bool expanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final persona = ref.watch(personaProvider);

    void select(Persona next) {
      if (next == persona) return;
      ref.read(personaProvider.notifier).set(next);
      CustomToast.showSuccess(
        message: next == Persona.student
            ? l10n.personaStudentToast
            : l10n.personaCompanyToast,
      );
    }

    final segments = [
      _Segment(
        icon: Icons.person_outline_rounded,
        label: l10n.personaStudent,
        color: AppColors.primary,
        selected: persona == Persona.student,
        onTap: () => select(Persona.student),
      ),
      _Segment(
        icon: Icons.apartment_rounded,
        label: l10n.personaCompany,
        color: AppColors.accentGreen,
        selected: persona == Persona.company,
        onTap: () => select(Persona.company),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.isDark
            ? AppColors.darkSurfaceSecondary
            : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
        children: [for (final s in segments) expanded ? Expanded(child: s) : s],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.icon,
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = selected
        ? AppColors.white
        : Theme.of(context).colorScheme.onSurface.withOpacity(0.7);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: selected ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 15, color: fg),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
