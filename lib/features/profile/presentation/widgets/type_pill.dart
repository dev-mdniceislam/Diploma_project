import 'package:flutter/material.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../data/profile_models.dart';
import '../../profile_core.dart';
import 'status_pill.dart';

class TypePill extends StatelessWidget {
  const TypePill(this.type, {super.key});

  final PostType type;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final job = type == PostType.job;
    return StatusPill(
      label: job ? l.pfTypeJob : l.pfTypeAttachment,
      color: job ? context.palette.brand : AppColors.urgent,
      icon: job ? Icons.work_outline_rounded : Icons.school_outlined,
    );
  }
}
