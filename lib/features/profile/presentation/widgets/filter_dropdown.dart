import 'package:flutter/material.dart';

import '../../profile_core.dart';
import 'profile_theme_x.dart';

class FilterDropdown extends StatelessWidget {
  const FilterDropdown({super.key, required this.value, required this.items, required this.onChanged});

  final String value;
  final Map<String, String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: cs.onSurface.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: cs.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          items: [
            for (final e in items.entries)
              DropdownMenuItem(
                value: e.key,
                child: CustomText(e.value, style: context.tt.bodySmall!.copyWith(fontWeight: FontWeight.w700)),
              ),
          ],
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

/// pfAll + the three apply statuses, in the order used by both screens.
Map<String, String> statusFilterItems(AppLocalizations l) => {
      'all': l.pfAll,
      'shortlisted': l.pfShortlisted,
      'pending': l.pfPending,
      'interview': l.pfInterview,
    };
