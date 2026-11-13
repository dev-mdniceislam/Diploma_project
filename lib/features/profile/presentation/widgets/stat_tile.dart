import 'package:flutter/material.dart';

import '../../profile_core.dart';
import 'profile_theme_x.dart';
import 'profile_header.dart';

class StatTile extends StatelessWidget {
  const StatTile(this.s, {super.key});

  final HeaderStat s;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final color = s.color ?? context.palette.brand;
    final iconed = s.icon != null;

    final label = CustomText(
      s.label,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: iconed ? TextAlign.start : TextAlign.center,
      style: tt.bodySmall!.copyWith(fontWeight: FontWeight.w700, color: AppColors.textMuted),
    );
    final value = s.child ??
        CustomText(
          s.value ?? '',
          textAlign: iconed ? TextAlign.start : TextAlign.center,
          style: tt.titleLarge!.copyWith(fontSize: iconed ? 20 : 15, fontWeight: FontWeight.w800, color: color),
        );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .07),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd + 4),
        border: Border.all(color: color.withValues(alpha: .18)),
      ),
      child: iconed
          ? Row(
              spacing: 12,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
                  child: Icon(s.icon, size: 20, color: Colors.white),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [label, value],
                  ),
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [label, value],
            ),
    );
  }
}
