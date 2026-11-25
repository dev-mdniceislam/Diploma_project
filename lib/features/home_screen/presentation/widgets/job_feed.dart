import 'package:diploma_job/features/home_screen/domain/entities/job_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_overlay_notification.dart';
import '../../../../core/widgets/custom_text.dart';
import '../providers/home_providers.dart';
import 'empty_jobs_state.dart';
import 'job_card.dart';
import 'job_pagination_bar.dart';

enum JobFeedLayout { list, grid }

class JobFeed extends ConsumerStatefulWidget {
  const JobFeed({
    super.key,
    required this.onApply,
    this.layout = JobFeedLayout.grid,
  });

  final ValueChanged<JobListItem> onApply;
  final JobFeedLayout layout;

  @override
  ConsumerState<JobFeed> createState() => _JobFeedState();
}

class _JobFeedState extends ConsumerState<JobFeed> {
  /// feed-এর শুরুতে যাওয়ার জন্য anchor। পেজ বদলালে এখানে scroll হবে।
  final _anchorKey = GlobalKey();

  void _goToPage(int page) {
    ref.read(jobPageProvider.notifier).goTo(page);

    final ctx = _anchorKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final async = ref.watch(jobsProvider);
    final filter = ref.watch(jobFilterProvider);
    final saved = ref.watch(savedJobsProvider);

    return KeyedSubtree(
      key: _anchorKey,
      child: async.when(
        // পেজ বদলের সময় আগের কার্ডগুলো রেখে দেয়, শুধু একটু ফ্যাকাশে হয়।
        skipLoadingOnReload: true,
        loading: () {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 64),
            child: Center(child: CircularProgressIndicator()),
          );
        },
        error: (e, __) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(l10n.errorLoading),
                const SizedBox(height: 12),
                CustomButton(
                  label: l10n.retry,
                  buttonHeight: 40,
                  onPressed: () => ref.invalidate(jobsProvider),
                ),
              ],
            ),
          );
        },
        data: (feed) {
          final jobs = filter.apply(feed.jobs);
          final pagination = feed.pagination;
          final busy = async.isLoading;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: busy ? 0.5 : 1,
                child: jobs.isEmpty
                    ? const EmptyJobsState()
                    : _buildCards(context, jobs, saved),
              ),
              if (pagination.total > 0) ...[
                const SizedBox(height: 24),
                JobPaginationBar(
                  pagination: pagination,
                  visibleCount: jobs.length,
                  isBusy: busy,
                  onPageSelected: _goToPage,
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildCards(
    BuildContext context,
    List<JobListItem> jobs,
    Set<String> saved,
  ) {
    final l10n = context.l10n;

    Widget card(JobListItem job) => JobCard(
      key: ValueKey(job.id),
      job: job,
      isSaved: saved.contains(job.id),
      onApply: () => widget.onApply(job),
      onToggleSave: () {
        final added = ref.read(savedJobsProvider.notifier).toggle(job.id);
        CustomToast.showSuccess(
          message: added ? l10n.savedAdded : l10n.savedRemoved,
        );
      },
    );

    if (widget.layout == JobFeedLayout.list) {
      return Column(
        children: [
          for (final job in jobs) ...[card(job), const SizedBox(height: 16)],
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 1100 ? 3 : (width >= 700 ? 2 : 1);
        const gap = 16.0;
        final cardWidth = (width - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final job in jobs)
              SizedBox(width: cardWidth, child: card(job)),
          ],
        );
      },
    );
  }
}
