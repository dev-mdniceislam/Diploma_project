import 'package:flutter/material.dart';

import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';

class SegmentedOption<T> {
  const SegmentedOption({
    required this.value,
    required this.label,
    this.icon,
    this.color = AppColors.primary,
  });

  final T value;
  final String label;
  final IconData? icon;
  final Color color;
}

/// Generic 2–3 option segmented switch (auth role switch, etc.).
class SegmentedToggle<T> extends StatelessWidget {
  const SegmentedToggle({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.expanded = true,
  });

  final List<SegmentedOption<T>> options;
  final T selected;
  final ValueChanged<T> onChanged;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.isDark
            ? AppColors.darkSurfaceSecondary
            : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
        children: [
          for (final o in options)
            expanded
                ? Expanded(child: _Segment(option: o, selected: o.value == selected, onTap: () => onChanged(o.value)))
                : _Segment(option: o, selected: o.value == selected, onTap: () => onChanged(o.value)),
        ],
      ),
    );
  }
}

class _Segment<T> extends StatelessWidget {
  const _Segment({required this.option, required this.selected, required this.onTap});

  final SegmentedOption<T> option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = selected ? option.color : scheme.onSurface.withOpacity(0.6);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? scheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: selected
                ? [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4, offset: const Offset(0, 1))]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (option.icon != null) ...[
                Icon(option.icon, size: 16, color: fg),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  option.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
