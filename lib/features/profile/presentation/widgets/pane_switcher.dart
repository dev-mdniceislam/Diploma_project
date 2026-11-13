import 'package:flutter/material.dart';

import '../../profile_core.dart';

/// Cross-fades between tab panes without layout jumps.
class PaneSwitcher extends StatelessWidget {
  const PaneSwitcher({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOut,
      layoutBuilder: (current, previous) => Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topCenter,
        children: [...previous, ?current],
      ),
      child: KeyedSubtree(key: ValueKey(index), child: child),
    );
  }
}
