import 'package:flutter/material.dart';

import '../widgets/home_feed_section.dart';
import '../widgets/home_hero.dart';

/// Page body only — navbar, drawer, footer and scrolling live in AppShell.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHero(),
        HomeFeedSection(onApply: (value) {}),
      ],
    );
  }
}
