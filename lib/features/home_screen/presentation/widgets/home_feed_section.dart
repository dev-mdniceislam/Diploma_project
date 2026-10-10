import 'package:flutter/material.dart';

import '../../../../core/widgets/app_container.dart';
import '../../domain/entities/job.dart';
import 'job_feed.dart';
import 'tech_filter_chips.dart';
import 'type_tabs_bar.dart';

/// Main content under the hero: tech chips → type tabs → circular grid.
class HomeFeedSection extends StatelessWidget {
  const HomeFeedSection({super.key, required this.onApply});

  final ValueChanged<Job> onApply;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TechFilterChips(),
            const SizedBox(height: 32),
            const TypeTabsBar(),
            const SizedBox(height: 24),
            JobFeed(onApply: onApply),
          ],
        ),
      ),
    );
  }
}