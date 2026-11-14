import 'package:diploma_job/features/profile/data/profile_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../data/model/company_profile_model.dart';
import '../../../profile_core.dart';
import '../../../providers/ui_state_provider.dart';
import '../../widgets/profile_widgets.dart';

class PostingCard extends ConsumerWidget {
  const PostingCard(this.po, {super.key});

  final Posting po;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final tt = context.tt;
    final palette = context.palette;
    final isJob = po.jobType == 'job';

    Widget line(IconData icon, Color color, String text) => Row(
      spacing: 6,
      children: [
        Icon(icon, size: 14, color: color),
        Expanded(child: CustomText(text, style: tt.bodySmall)),
      ],
    );

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TypePill(PostType.parse(po.jobType)),
                CustomText(
                  l.pfSeats(context.fmtDigits(po.vacancies)),
                  style: tt.bodySmall,
                ),
              ],
            ),
            CustomText(
              po.title,
              style: tt.titleMedium!.copyWith(color: context.cs.onSurface),
            ),
            if (po.location.isNotEmpty)
              line(
                Icons.place_outlined,
                AppColors.textMuted,
                l.pfPlace(po.location),
              ),
            const Divider(height: 1),
            line(
              Icons.payments_outlined,
              palette.success,
              isJob
                  ? l.pfSalary(context.fmtDigits(po.stipend))
                  : l.pfStipend(context.fmtDigits(po.stipend)),
            ),
            line(
              Icons.schedule_rounded,
              AppColors.urgent,
              l.pfDeadline(context.fmtDate(po.deadline)),
            ),
            const Divider(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () =>
                      ref.read(companyTabProvider.notifier).select(1),
                  icon: const Icon(Icons.people_outline_rounded, size: 16),
                  label: Text(
                    l.pfViewApplicants(context.fmtDigits(po.applicantCount)),
                  ),
                ),
                if (po.isApplicationOpen)
                  StatusPill(label: l.pfActive, color: palette.success),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
