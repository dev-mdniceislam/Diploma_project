import 'package:flutter/material.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../domain/entities/job_circular.dart';
import 'job_core.dart';

extension JobThemeX on BuildContext {
  ColorScheme get scheme => Theme.of(this).colorScheme;

  Color get mutedSurface =>
      isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceSecondary;

  Color get bodyColor =>
      isDark ? AppColors.textOnDarkMuted : AppColors.textSecondary;

  /// "8th Semester" / "৮ম সেমিস্টার"
  String semesterName(int n) => l10n.semesterLabel(l10n.ordinal('$n'));

  String circularTypeLabel(CircularType type, int? semester) => switch (type) {
    CircularType.attachment => l10n.typeSemesterAttachment(
      semesterName(semester ?? 8),
    ),
    CircularType.job => l10n.typeFullTimeJob,
  };

  String reviewStatusLabel(ReviewStatus s) => switch (s) {
    ReviewStatus.pending => l10n.statusPending,
    ReviewStatus.shortlisted => l10n.statusShortlisted,
    ReviewStatus.interview => l10n.statusInterview,
  };
}

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimens.md),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: context.scheme.outline),
      ),
      child: child,
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.large = false,
  });

  final IconData icon;
  final String title;
  final Color? iconColor;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final base = large ? AppTextStyles.titleLarge : AppTextStyles.titleMedium;
    return Row(
      children: [
        Icon(
          icon,
          size: large ? 22 : 19,
          color: iconColor ?? context.palette.brand,
        ),
        const SizedBox(width: AppDimens.xs + 2),
        Expanded(
          child: CustomText(
            title,
            style: base.copyWith(color: context.scheme.onSurface),
          ),
        ),
      ],
    );
  }
}

class InfoBadge extends StatelessWidget {
  const InfoBadge({
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

/// Rounded tile holding an icon (HR rows, benefit rows …).
class IconTile extends StatelessWidget {
  const IconTile({super.key, required this.icon, this.color, this.background});

  final IconData icon;
  final Color? color;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background ?? context.mutedSurface,
        borderRadius: BorderRadius.circular(AppDimens.radiusSm + 2),
      ),
      child: Icon(icon, size: 17, color: color ?? context.bodyColor),
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
