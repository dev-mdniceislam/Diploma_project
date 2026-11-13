import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../../providers/profile_providers.dart';
import '../../widgets/profile_widgets.dart';
import 'company_overview_tab.dart';
import 'postings_tab.dart';
import 'applicants_tab.dart';
import 'mou_tab.dart';

class CompanyTabs extends ConsumerWidget {
  const CompanyTabs(this.p, {super.key});

  final CompanyProfile p;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i = ref.watch(companyTabProvider);
    final l = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppDimens.md,
      children: [
        ChipBar(
          index: i,
          onChanged: ref.read(companyTabProvider.notifier).select,
          items: [
            (
              label: l.pfTabPostings,
              icon: Icons.campaign_outlined,
              badge: context.fmtNumber(p.postings.length),
            ),
            (
              label: l.pfTabApplicants,
              icon: Icons.people_outline_rounded,
              badge: context.fmtNumber(p.applicationCount),
            ),
            (
              label: l.pfTabCompany,
              icon: Icons.info_outline_rounded,
              badge: null,
            ),
            (
              label: l.pfTabMou,
              icon: Icons.workspace_premium_outlined,
              badge: null,
            ),
          ],
        ),
        PaneSwitcher(
          index: i,
          child: switch (i) {
            0 => PostingsTab(p),
            1 => ApplicantsTab(p),
            2 => CompanyOverviewTab(p),
            _ => MouTab(p),
          },
        ),
      ],
    );
  }
}
