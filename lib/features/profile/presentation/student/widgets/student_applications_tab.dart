import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../../data/model/student_profile_model.dart';
import '../../../data/profile_models.dart'; // ApplyStatus
import '../../../profile_core.dart';
import '../../../providers/ui_state_provider.dart';
import '../../widgets/profile_widgets.dart';

/// Takes the LIST of the student's applications (one StudentApplicationModel
/// is a single row, so it can not be the tab's `p`).
class StudentApplicationsTab extends ConsumerWidget {
  const StudentApplicationsTab(this.applications, {super.key});

  final List<StudentApplicationModel> applications;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final tt = context.tt;
    final filter = ref.watch(studentAppFilterProvider);

    // API says 'applied' -> shown as "pending"; shortlisted / interview match by name.
    final shown = filter == 'all'
        ? applications
        : applications.where((a) => ApplyStatus.parse(a.status).name == filter);

    return ProfileCard(
      title: l.pfTrackerTitle,
      subtitle: l.pfTrackerSub,
      trailing: FilterDropdown(
        value: filter,
        items: statusFilterItems(l),
        onChanged: ref.read(studentAppFilterProvider.notifier).select,
      ),
      child: ProfileTable(
        columns: [l.pfColCompany, l.pfStatus, l.pfColAction],
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
                  CustomText(a.company, style: tt.bodySmall),
                ],
              ),
              ApplyStatusPill(ApplyStatus.parse(a.status)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (a.shortMessage.isNotEmpty)
                    TextButton(
                      onPressed: () =>
                          CustomToast.showSuccess(message: a.shortMessage),
                      child: Text(l.pfViewMessage),
                    ),
                  if (a.cv.isNotEmpty)
                    TextButton(
                      onPressed: () => openLink(context, a.cv),
                      child: const Text('CV'),
                    ),
                ],
              ),
            ],
        ],
      ),
    );
  }
}
