import 'package:flutter/material.dart';

import '../../profile_core.dart';
import 'profile_theme_x.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.trailing,
    this.gradient,
  });

  final Widget child;
  final String? title, subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Widget? trailing;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final onDark = gradient != null;
    final fg = onDark ? AppColors.textOnDark : cs.onSurface;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.value(context, mobile: 16.0, desktop: 24.0)),
      decoration: BoxDecoration(
        color: onDark ? null : cs.surface,
        gradient: gradient,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg - 4),
        border: Border.all(color: onDark ? Colors.transparent : cs.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimens.md - 4,
        children: [
          if (title != null)
            Row(
              spacing: 8,
              children: [
                if (icon != null) Icon(icon, size: 20, color: iconColor ?? context.palette.brand),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(title!, style: context.tt.titleMedium!.copyWith(color: fg)),
                      if (subtitle != null) CustomText(subtitle!, style: context.tt.bodySmall),
                    ],
                  ),
                ),
                ?trailing,
              ],
            ),
          child,
        ],
      ),
    );
  }
}
