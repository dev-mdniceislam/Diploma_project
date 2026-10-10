import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_overlay_notification.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/responsive_grid.dart';
import '../../domain/entities/job.dart';
import '../providers/home_providers.dart';
import 'empty_jobs_state.dart';
import 'job_card.dart';

/// Loading / error / empty / grid states for the circular list.
class JobFeed extends ConsumerWidget {
  const JobFeed({super.key, required this.onApply});

  final ValueChanged<Job> onApply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final jobsAsync = ref.watch(filteredJobsProvider);

    return jobsAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 64),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
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
      ),
      data: (jobs) {
        if (jobs.isEmpty) return const EmptyJobsState();

        final saved = ref.watch(savedJobsProvider);
        return ResponsiveGrid(
          children: [
            for (final job in jobs)
              JobCard(
                key: ValueKey(job.id),
                job: job,
                isSaved: saved.contains(job.id),
                onApply: () => onApply(job),
                onToggleSave: () {
                  final added = ref
                      .read(savedJobsProvider.notifier)
                      .toggle(job.id);
                  CustomToast.showSuccess(
                    message: added ? l10n.savedAdded : l10n.savedRemoved,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}