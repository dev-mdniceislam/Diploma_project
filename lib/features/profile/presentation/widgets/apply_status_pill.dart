import 'package:flutter/material.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/utils/localized_format.dart';
import '../../data/profile_models.dart';
import '../../profile_core.dart';
import 'status_pill.dart';

/// pending / shortlisted / interview, shared by both tables.
class ApplyStatusPill extends StatelessWidget {
  const ApplyStatusPill(this.status, {super.key, this.interviewAt});

  final ApplyStatus status;
  final DateTime? interviewAt;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return switch (status) {
      ApplyStatus.shortlisted => StatusPill(
        label: l.pfShortlisted,
        color: context.palette.success,
        icon: Icons.check_circle_rounded,
      ),
      ApplyStatus.interview => StatusPill(
        label: interviewAt == null
            ? l.pfInterview
            : l.pfInterviewOn(context.fmtDate(interviewAt!)),
        color: AppColors.featured,
        icon: Icons.event_rounded,
      ),
      ApplyStatus.pending => StatusPill(
        label: l.pfPending,
        color: AppColors.textSecondary,
        icon: Icons.schedule_rounded,
      ),
    };
  }
}
