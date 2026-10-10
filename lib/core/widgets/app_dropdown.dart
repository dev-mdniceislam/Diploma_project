import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class AppDropdownItem<T> {
  const AppDropdownItem({required this.value, required this.label});
  final T value;
  final String label;
}

/// Bordered dropdown that follows the app theme.
/// Pass [fillColor]/[textColor]/[dropdownColor] to force a light look (e.g. on
/// the always-white hero search card).
class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.prefixIcon,
    this.dense = false,
    this.fillColor,
    this.textColor,
    this.dropdownColor,
  });

  final T value;
  final List<AppDropdownItem<T>> items;
  final ValueChanged<T> onChanged;
  final IconData? prefixIcon;
  final bool dense;
  final Color? fillColor;
  final Color? textColor;
  final Color? dropdownColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = textColor ?? scheme.onSurface;

    final dropdown = DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: value,
        isExpanded: !dense,
        borderRadius: BorderRadius.circular(12),
        dropdownColor: dropdownColor ?? scheme.surface,
        icon: Icon(Icons.keyboard_arrow_down_rounded,
            size: 20, color: AppColors.textMuted),
        style: AppTextStyles.bodyMedium.copyWith(
          color: fg,
          fontSize: dense ? 12.5 : 14,
          fontWeight: FontWeight.w500,
        ),
        items: [
          for (final item in items)
            DropdownMenuItem<T>(
              value: item.value,
              child: Text(item.label, overflow: TextOverflow.ellipsis),
            ),
        ],
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );

    return Container(
      height: dense ? 38 : 48,
      padding: EdgeInsets.symmetric(horizontal: dense ? 10 : 14),
      decoration: BoxDecoration(
        color: fillColor ?? scheme.surface,
        borderRadius: BorderRadius.circular(dense ? 8 : 12),
        border: Border.all(
          color: dense ? scheme.outline : AppColors.borderStrong,
        ),
      ),
      child: Row(
        mainAxisSize: dense ? MainAxisSize.min : MainAxisSize.max,
        children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon, size: 20, color: AppColors.textMuted),
            const SizedBox(width: 10),
          ],
          if (dense) dropdown else Expanded(child: dropdown),
        ],
      ),
    );
  }
}
