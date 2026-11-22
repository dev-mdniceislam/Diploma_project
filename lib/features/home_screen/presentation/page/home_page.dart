import 'package:diploma_job/core/utils/shell_page.dart';
import 'package:diploma_job/features/home_screen/presentation/providers/home_providers.dart';
import 'package:diploma_job/features/home_screen/presentation/widgets/hero_section/home_hero.dart';
import 'package:diploma_job/features/splash/presentation/provider/user_profile_provider.dart';
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
    return ShellPage(
      onRefresh: () => _refresh(ref),
      children: [
        const HomeHero(),
        HomeFeedSection(onApply: (value) {}),
      ],
    );
  }
}
