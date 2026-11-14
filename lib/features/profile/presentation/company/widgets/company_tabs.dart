import 'package:diploma_job/features/profile/data/model/company_profile_model.dart';
import 'package:diploma_job/features/profile/providers/company_application_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../profile_core.dart';
import '../../../providers/company_posting_provider.dart';
import '../../../providers/ui_state_provider.dart';
import '../../widgets/profile_widgets.dart';
import 'applicants_tab.dart';
import 'company_actions.dart';
import 'company_overview_tab.dart';
import 'mou_tab.dart';
import 'postings_tab.dart';

class CompanyTabs extends ConsumerWidget {
  const CompanyTabs(this.p, {super.key});

  final CompanyProfileModel p;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i = ref.watch(companyTabProvider);
    final l = context.l10n;
    final postingCount = ref.watch(companyPostingsProvider).value?.length ?? 0;
    final applicantCount =
        ref.watch(companyApplicantsProvider).value?.length ?? 0;

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
              badge: context.fmtNumber(postingCount),
            ),
            (
              label: l.pfTabApplicants,
              icon: Icons.people_outline_rounded,
              badge: context.fmtNumber(applicantCount),
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
            0 => const PostingsTab(),
            1 => _applicants(context, ref),
            2 => CompanyOverviewTab(p),
            _ => MouTab(p),
          },
        ),
      ],
    );
  }

  Widget _applicants(BuildContext context, WidgetRef ref) {
    final async = ref.watch(companyApplicantsProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (applicants) => ApplicantsTab(
        applicants,
        onShortlist: (a) => shortlistApplicant(context, ref, a),
        onSchedule: (a) => scheduleInterview(context, ref, a),
      ),
    );
  }
}
