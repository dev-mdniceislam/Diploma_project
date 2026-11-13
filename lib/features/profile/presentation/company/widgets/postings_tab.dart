import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../../providers/profile_providers.dart';
import '../../widgets/profile_widgets.dart';
import 'posting_card.dart';

class PostingsTab extends ConsumerWidget {
  const PostingsTab(this.p, {super.key});

  final CompanyProfile p;

  static const _filters = ['all', 'job', 'attachment'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final filter = ref.watch(postingFilterProvider);
    final shown = filter == 'all' ? p.postings : p.postings.where((x) => x.type.name == filter);

    return Column(
      spacing: AppDimens.md - 4,
      children: [
        Row(
          spacing: 10,
          children: [
            const Icon(Icons.filter_list_rounded, size: 20, color: AppColors.textMuted),
            Expanded(
              child: ChipBar(
                compact: true,
                index: _filters.indexOf(filter),
                onChanged: (i) => ref.read(postingFilterProvider.notifier).select(_filters[i]),
                items: [
                  (label: l.pfAllPosts(context.fmtDigits(p.postings.length)), icon: null, badge: null),
                  (label: l.pfJobsCount(context.fmtDigits(p.jobCount)), icon: null, badge: null),
                  (label: l.pfAttachCount(context.fmtDigits(p.attachmentCount)), icon: null, badge: null),
                ],
              ),
            ),
          ],
        ),
        ResponsiveWrap(
          mobile: 1,
          tablet: 2,
          desktop: 3,
          children: [for (final po in shown) PostingCard(po)],
        ),
      ],
    );
  }
}
