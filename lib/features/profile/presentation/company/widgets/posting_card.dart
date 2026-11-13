import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../../providers/profile_providers.dart';
import '../../widgets/profile_widgets.dart';

class PostingCard extends ConsumerWidget {
  const PostingCard(this.po, {super.key});

  final Posting po;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final tt = context.tt;
    final palette = context.palette;
    final isJob = po.type == PostType.job;

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
                TypePill(po.type),
                CustomText(
                  l.pfSeats(context.fmtDigits(po.seats)),
                  style: tt.bodySmall,
                ),
              ],
            ),
            CustomText(
              po.title,
              style: tt.titleMedium!.copyWith(color: context.cs.onSurface),
            ),
            if (po.tech.isNotEmpty)
              CustomText(l.pfTechnologyLine(po.tech), style: tt.bodySmall),
            if (po.tags.isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final t in po.tags)
                    StatusPill(label: t, color: AppColors.textSecondary),
                ],
              ),
            const Divider(height: 1),
            line(
              Icons.place_outlined,
              AppColors.textMuted,
              l.pfPlace(po.location),
            ),
            line(
              Icons.payments_outlined,
              palette.success,
              isJob
                  ? l.pfSalary(context.fmtDigits(po.salary))
                  : l.pfStipend(context.fmtDigits(po.salary)),
            ),
            if (po.deadline != null)
              line(
                Icons.schedule_rounded,
                AppColors.urgent,
                l.pfDeadline(context.fmtDate(po.deadline!)),
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
                    l.pfViewApplicants(context.fmtDigits(po.applicants)),
                  ),
                ),
                if (po.active)
                  StatusPill(label: l.pfActive, color: palette.success),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
