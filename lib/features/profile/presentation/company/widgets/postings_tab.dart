import 'package:diploma_job/core/router/app_router.dart';
import 'package:diploma_job/features/home_screen/presentation/widgets/job_card.dart';
import 'package:diploma_job/features/profile/presentation/company/widgets/profile_job_posting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../profile_core.dart';
import '../../../providers/company_posting_provider.dart';
import '../../../providers/ui_state_provider.dart';
import '../../widgets/profile_widgets.dart';

class PostingsTab extends ConsumerWidget {
  const PostingsTab({super.key});

  static const _filters = ['all', 'job', 'attachment'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final filter = ref.watch(postingFilterProvider);
    final postingsAsync = ref.watch(companyPostingsProvider);

    return postingsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (postings) {
        final jobCount = postings.where((x) => x.jobType == 'job').length;
        final attachmentCount = postings
            .where((x) => x.jobType == 'attachment')
            .length;

        final shown = filter == 'all'
            ? postings
            : postings.where((x) => x.jobType == filter).toList();

        return Column(
          spacing: AppDimens.md - 4,
          children: [
            Row(
              spacing: 10,
              children: [
                const Icon(
                  Icons.filter_list_rounded,
                  size: 20,
                  color: AppColors.textMuted,
                ),
                Expanded(
                  child: ChipBar(
                    compact: true,
                    index: _filters.indexOf(filter),
                    onChanged: (i) => ref
                        .read(postingFilterProvider.notifier)
                        .select(_filters[i]),
                    items: [
                      (
                        label: l.pfAllPosts(context.fmtDigits(postings.length)),
                        icon: null,
                        badge: null,
                      ),
                      (
                        label: l.pfJobsCount(context.fmtDigits(jobCount)),
                        icon: null,
                        badge: null,
                      ),
                      (
                        label: l.pfAttachCount(
                          context.fmtDigits(attachmentCount),
                        ),
                        icon: null,
                        badge: null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ResponsiveWrap(
              mobile: 1,
              tablet: 2,
              desktop: 3,
              children: [
                for (final po in shown)
                  JobPostingCard(
                    job: po,
                    onViewApplicants: () {},
                    jobCardTap: () => context.go(AppRoutes.myDetailsOf(po.id)),
                  ),
                //JobCard(job: po, isMyProfile: true, onApply: () {}),
              ],
            ),
          ],
        );
      },
    );
  }
}
