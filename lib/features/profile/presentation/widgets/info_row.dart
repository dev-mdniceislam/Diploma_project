import 'package:flutter/material.dart';

import '../../profile_core.dart';
import 'profile_theme_x.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.icon, required this.label, required this.value, this.onTap});

  final IconData icon;
  final String label, value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.cs.onSurface.withValues(alpha: .06),
            borderRadius: BorderRadius.circular(AppDimens.radiusSm + 2),
          ),
          child: Icon(icon, size: 16, color: AppColors.textMuted),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(label, style: context.tt.bodySmall!.copyWith(fontWeight: FontWeight.w700, color: AppColors.textMuted)),
              CustomText(
                value.isEmpty ? '—' : value,
                style: context.tt.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: onTap == null ? context.cs.onSurface : context.palette.brand,
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return onTap == null ? row : InkWell(onTap: onTap, child: row);
  }
}
