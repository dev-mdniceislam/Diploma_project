import 'package:diploma_job/core/utils/shell_page.dart';
import 'package:diploma_job/features/home_screen/presentation/widgets/hero_section/home_hero.dart';
import 'package:flutter/material.dart';

import '../widgets/home_feed_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShellPage(
      children: [
        const HomeHero(),
        HomeFeedSection(onApply: (value) {}),
      ],
    );
  }
}
