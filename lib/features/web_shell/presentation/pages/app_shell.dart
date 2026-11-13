import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../provider/web_shell_provider.dart';
import '../widget/mobile_nav_drawer.dart';
import '../widget/navbar/main_navbar.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: const MobileNavDrawer(),
      body: Column(
        children: [
          const MainNavbar(),
          Divider(height: 1, color: scheme.outline),
          Expanded(child: child), // bounded height, scroll এখানে নেই
        ],
      ),
      floatingActionButton: const _ScrollToTopButton(),
    );
  }
}

class _ScrollToTopButton extends ConsumerWidget {
  const _ScrollToTopButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScrolled = ref.watch(webShellProvider.select((s) => s.isScrolled));
    final controller = ref.read(scrollControllerProvider);

    return AnimatedScale(
      scale: isScrolled ? 1 : 0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        opacity: isScrolled ? 1 : 0,
        duration: const Duration(milliseconds: 250),
        child: FloatingActionButton.small(
          elevation: 4,
          hoverElevation: 8,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onPressed: () => controller.animateTo(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.fastOutSlowIn,
          ),
          child: const Icon(Icons.arrow_upward_rounded, size: 20),
        ),
      ),
    );
  }
}
