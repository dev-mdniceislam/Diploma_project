import 'package:diploma_job/features/profile/data/model/student_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../../providers/profile_providers.dart';
import '../../../providers/ui_state_provider.dart';
import '../../widgets/profile_widgets.dart';

class StudentApplicationsTab extends ConsumerWidget {
  const StudentApplicationsTab(this.p, {super.key});

  final StudentFullProfileModel p;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final tt = context.tt;
    final filter = ref.watch(studentAppFilterProvider);
    final shown = filter == 'all'
        ? p.applications
        : p.applications.where((a) => a.status.name == filter);

    return ProfileCard(
      title: l.pfTrackerTitle,
      subtitle: l.pfTrackerSub,
      trailing: FilterDropdown(
        value: filter,
        items: statusFilterItems(l),
        onChanged: ref.read(studentAppFilterProvider.notifier).select,
      ),
      child: ProfileTable(
        columns: [
          l.pfColCompany,
          l.pfColType,
          l.pfColDate,
          l.pfStatus,
          l.pfColAction,
        ],
        rows: <List<Widget>>[
          for (final a in shown)
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    a.company,
                    style: tt.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.cs.onSurface,
                    ),
                  ),
                  CustomText(a.role, style: tt.bodySmall),
                ],
              ),
              TypePill(a.type),
              CustomText(
                a.appliedAt == null ? '—' : context.fmtDate(a.appliedAt!),
              ),
              ApplyStatusPill(a.status),
              a.message.isEmpty
                  ? const SizedBox.shrink()
                  : TextButton(
                      onPressed: () =>
                          CustomToast.showSuccess(message: a.message),
                      child: Text(l.pfViewMessage),
                    ),
            ],
        ],
      ),
    );
  }
}
