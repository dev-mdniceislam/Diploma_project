import 'package:flutter/material.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../domain/entities/student_profile.dart';
import 'profile_core.dart';

extension ProfileThemeX on BuildContext {
  ColorScheme get scheme => Theme.of(this).colorScheme;

  /// Soft grey fill (table headers, chips, progress tracks).
  Color get mutedSurface =>
      isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceSecondary;

  /// Secondary body text that stays readable in both themes.
  Color get bodyColor =>
      isDark ? AppColors.textOnDarkMuted : AppColors.textSecondary;

  /// "Semester 3" / "৩য় সেমিস্টার"
  String semesterName(int n) => l10n.semesterLabel(l10n.ordinal('$n'));
}

Color skillToneColor(SkillTone tone) => switch (tone) {
      SkillTone.primary => AppColors.primary600,
      SkillTone.success => AppColors.accentGreen,
      SkillTone.info => AppColors.featured,
      SkillTone.warning => AppColors.amber,
    };

/// Bordered surface used by every section on the profile page.
class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimens.md),
    this.gradient,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? context.scheme.surface : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(
          color: gradient == null ? context.scheme.outline : Colors.transparent,
        ),
      ),
      child: child,
    );
  }
}

/// Icon + title row, optional trailing widget.
class CardTitle extends StatelessWidget {
  const CardTitle({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final Color? iconColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor ?? context.scheme.primary),
        const SizedBox(width: AppDimens.xs + 2),
        Expanded(
          child: CustomText(
            title,
            style: AppTextStyles.titleMedium.copyWith(
              color: context.scheme.onSurface,
            ),
          ),
        ),
        ?trailing,
      ],
    );
  }
}

/// Title + subtitle on the left, action on the right (wraps on mobile).
class PanelHeader extends StatelessWidget {
  const PanelHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            color: context.scheme.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        CustomText(
          subtitle,
          style: AppTextStyles.bodySmall.copyWith(color: context.bodyColor),
        ),
      ],
    );

    if (Responsive.isMobile(context)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [text, const SizedBox(height: AppDimens.sm), trailing],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Expanded(child: text), trailing],
    );
  }
}

/// Small coloured pill (status, verified, type …).
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.foreground,
    required this.background,
    this.icon,
  });

  final String label;
  final Color foreground;
  final Color background;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimens.radiusSm + 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: foreground),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: CustomText(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: foreground,
                fontWeight: FontWeight.w700,
                fontSize: 11.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Muted label above a bold value.
class LabeledValue extends StatelessWidget {
  const LabeledValue({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        CustomText(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.scheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// Two form fields side by side on larger screens, stacked on mobile.
class FieldPair extends StatelessWidget {
  const FieldPair({super.key, required this.first, required this.second});

  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return Column(
        children: [first, const SizedBox(height: AppDimens.sm), second],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: first),
        const SizedBox(width: AppDimens.sm),
        Expanded(child: second),
      ],
    );
  }
}
