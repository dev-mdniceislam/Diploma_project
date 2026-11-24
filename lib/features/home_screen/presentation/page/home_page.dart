import 'package:diploma_job/core/utils/shell_page.dart';
import 'package:diploma_job/features/home_screen/presentation/providers/home_providers.dart';
import 'package:diploma_job/features/home_screen/presentation/widgets/hero_section/home_hero.dart';
import 'package:diploma_job/features/profile/presentation/widgets/async_value_view.dart';
import 'package:diploma_job/features/splash/presentation/provider/user_profile_provider.dart';
import 'package:diploma_job/shared/shimmer/home_shimmer/home_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/home_feed_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    await Future.wait([
      ref.read(userProfileProvider.notifier).refresh(),
      ref.refresh(jobsProvider.future),
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(jobsProvider);

    final isInitialLoading = jobs.isLoading && !jobs.hasValue;
    if (isInitialLoading) {
      return const HomeShimmerPage();
    }

    return AsyncValueView(
      value: jobs,
      data: (data) {
        return ShellPage(
          onRefresh: () => _refresh(ref),
          children: [
            const HomeHero(),
            HomeFeedSection(onApply: (value) {}),
          ],
        );
      },
      onRetry: () => ref.invalidate(jobsProvider),
    );
  }
}
