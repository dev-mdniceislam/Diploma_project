import 'package:flutter/material.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../profile_core.dart';
import 'profile_theme_x.dart';

/// Theme-aware DataTable that scrolls horizontally on small screens.
class ProfileTable extends StatelessWidget {
  const ProfileTable({super.key, required this.columns, required this.rows});

  final List<String> columns;
  final List<List<Widget>> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppDimens.md),
        child: Center(
          child: CustomText(
            context.l10n.pfNoData,
            style: context.tt.bodyMedium,
          ),
        ),
      );
    }
    final cs = context.cs;
    return LayoutBuilder(
      builder: (_, c) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: c.maxWidth),
          child: DataTable(
            headingRowHeight: 44,
            dataRowMinHeight: 52,
            dataRowMaxHeight: 76,
            columnSpacing: 24,
            horizontalMargin: 12,
            dividerThickness: .6,
            headingRowColor: WidgetStatePropertyAll(
              cs.onSurface.withValues(alpha: .05),
            ),
            headingTextStyle: context.tt.bodySmall!.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
            columns: [
              for (final name in columns) DataColumn(label: Text(name)),
            ],
            rows: [
              for (final r in rows)
                DataRow(cells: [for (final w in r) DataCell(w)]),
            ],
          ),
        ),
      ),
    );
  }
}
