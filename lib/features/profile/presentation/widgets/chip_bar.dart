import 'package:flutter/material.dart';

import '../../profile_core.dart';
import 'profile_theme_x.dart';

typedef ChipItem = ({String label, IconData? icon, String? badge});

/// Horizontal scrolling chip bar. `compact` = small filter chips.
class ChipBar extends StatelessWidget {
  const ChipBar({
    super.key,
    required this.items,
    required this.index,
    required this.onChanged,
    this.compact = false,
  });

  final List<ChipItem> items;
  final int index;
  final ValueChanged<int> onChanged;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: [
          for (final (i, it) in items.indexed)
            Builder(builder: (_) {
              final selected = i == index;
              final fg = selected ? cs.onPrimary : cs.onSurface.withValues(alpha: .7);
              final radius = BorderRadius.circular(compact ? 8 : 12);
              return Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: radius,
                  onTap: () => onChanged(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 16, vertical: compact ? 7 : 10),
                    decoration: BoxDecoration(
                      color: selected ? cs.primary : cs.surface,
                      borderRadius: radius,
                      border: Border.all(color: selected ? cs.primary : cs.outline),
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        if (it.icon != null) Icon(it.icon, size: 16, color: fg),
                        CustomText(
                          it.label,
                          style: context.tt.bodySmall!.copyWith(fontWeight: FontWeight.w700, color: fg),
                        ),
                        if (it.badge != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                            decoration: BoxDecoration(
                              color: selected ? Colors.white24 : cs.primary.withValues(alpha: .12),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: CustomText(
                              it.badge!,
                              style: context.tt.bodySmall!.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: selected ? cs.onPrimary : cs.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
