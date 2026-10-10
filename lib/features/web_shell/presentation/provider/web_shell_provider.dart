import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebShellState {
  const WebShellState({this.isScrolled = false});

  /// True once the user scrolled past [WebShellNotifier.threshold]
  /// (shows the scroll-to-top button).
  final bool isScrolled;
}

class WebShellNotifier extends Notifier<WebShellState> {
  static const threshold = 300.0;

  @override
  WebShellState build() => const WebShellState();

  void onScroll(double offset) {
    final scrolled = offset > threshold;
    if (scrolled != state.isScrolled) {
      state = WebShellState(isScrolled: scrolled);
    }
  }
}

final webShellProvider =
    NotifierProvider<WebShellNotifier, WebShellState>(WebShellNotifier.new);

/// Single scroll controller for the whole shell body.
final scrollControllerProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(controller.dispose);
  return controller;
});
