import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/web_shell/presentation/provider/web_shell_provider.dart';
import '../../features/web_shell/presentation/widget/footer/app_footer.dart';

class ShellPage extends ConsumerWidget {
  const ShellPage({
    super.key,
    required this.children,
    this.onRefresh,
  });

  final List<Widget> children;

  /// Pull-to-refresh-এর সময় চলবে। না দিলে refresh বন্ধ থাকবে।
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(scrollControllerProvider);

    final scrollView = NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n is ScrollUpdateNotification && n.depth == 0) {
          ref.read(webShellProvider.notifier).onScroll(n.metrics.pixels);
        }
        return false;
      },
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          controller: scrollController,
          // RefreshIndicator-এর জন্য AlwaysScrollable দরকার, যাতে
          // content ছোট হলেও নিচে টানা যায়
          physics: onRefresh != null
              ? const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          )
              : const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [...children, const AppFooter()],
            ),
          ),
        ),
      ),
    );

    if (onRefresh == null) return scrollView;

    return RefreshIndicator(
      onRefresh: onRefresh!,
      child: scrollView,
    );
  }
}