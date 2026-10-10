import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.trailing,
    this.centered = false,
    this.light = false,
    this.centerWidget,
  });

  final String title;
  final Widget? trailing;
  final bool centered;
  final bool light;
  final Widget? centerWidget;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.headlineMedium
        .responsive(context)
        .copyWith(color: light ? AppColors.textOnDark : AppColors.primaryNavy);

    final heading = Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: style),
        const SizedBox(height: 8),
        Container(
          height: 3,
          width: 46,
          decoration: BoxDecoration(
            color: AppColors.accentGreen,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );

    if (trailing == null && centerWidget == null) return heading;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        heading,
        if (centerWidget != null) centerWidget!,
        if (trailing != null) trailing!,
      ],
    );
  }
}
