import 'package:diploma_job/features/profile/data/model/company_profile_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../profile_core.dart';
import 'status_pill.dart';

class TypePill extends StatelessWidget {
  const TypePill(this.type, {super.key});

  final JobType type;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final job = type == JobType.job;
    return StatusPill(
      label: job ? l.pfTypeJob : l.pfTypeAttachment,
      color: job ? context.palette.brand : AppColors.urgent,
      icon: job ? Icons.work_outline_rounded : Icons.school_outlined,
    );
  }
}
