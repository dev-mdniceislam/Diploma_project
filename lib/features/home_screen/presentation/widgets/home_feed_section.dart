import 'package:diploma_job/core/widgets/animated_reveal.dart';
import 'package:diploma_job/features/home_screen/domain/entities/job_filter.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/app_container.dart';
import 'job_feed.dart';
import 'type_tabs_bar.dart';

/// Main content under the hero: type tabs → job feed (with pagination).
class HomeFeedSection extends StatelessWidget {
  const HomeFeedSection({super.key, required this.onApply});

  final ValueChanged<JobListItem> onApply;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnimatedReveal(child: TypeTabsBar()),
            const SizedBox(height: 24),
            AnimatedReveal(child: JobFeed(onApply: onApply)),
          ],
        ),
      ),
    );
  }
}
