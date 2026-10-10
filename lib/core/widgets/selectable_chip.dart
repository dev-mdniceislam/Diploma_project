import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

/// Pill / tab button used by the technology chips and the type tabs.
class SelectableChip extends StatefulWidget {
  const SelectableChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.selectedColor = AppColors.primary,
    this.radius = 999,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedColor;
  final double radius;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  @override
  State<SelectableChip> createState() => _SelectableChipState();
}

class _SelectableChipState extends State<SelectableChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final selected = widget.selected;

    final Color bg = selected ? widget.selectedColor : scheme.surface;
    final Color border = selected
        ? widget.selectedColor
        : (_hover ? AppColors.primaryLight : scheme.outline);
    final Color fg = selected
        ? AppColors.white
        : (_hover ? AppColors.primary : scheme.onSurface.withOpacity(0.75));

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(color: border),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ),
      ),
    );
  }
}
