import 'package:flutter/material.dart';

import '../../profile_core.dart';
import 'profile_theme_x.dart';

/// Tab title + optional subtitle + optional trailing action (no card).
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.subtitle, this.trailing});

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: AppDimens.sm,
      spacing: AppDimens.sm,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(title, style: context.tt.titleLarge!.copyWith(color: context.cs.onSurface)),
            if (subtitle != null) CustomText(subtitle!, style: context.tt.bodySmall),
          ],
        ),
        ?trailing,
      ],
    );
  }
}
