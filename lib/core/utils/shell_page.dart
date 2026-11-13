import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/web_shell/presentation/provider/web_shell_provider.dart';
import '../../features/web_shell/presentation/widget/footer/app_footer.dart';

class ShellPage extends ConsumerWidget {
  const ShellPage({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(scrollControllerProvider);

    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n is ScrollUpdateNotification && n.depth == 0) {
          ref.read(webShellProvider.notifier).onScroll(n.metrics.pixels);
        }
        return false;
      },
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          controller: scrollController,
          physics: const ClampingScrollPhysics(),
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
  }
}
