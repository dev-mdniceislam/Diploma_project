import 'package:flutter/foundation.dart';

import '../../domain/entities/job.dart';

/// Navigation / modal hooks, injected from [HomePage] so the widgets stay
/// decoupled from routing (go_router etc.).
@immutable
class HomeCallbacks {
  const HomeCallbacks({
    required this.onPostCircular,
    required this.onOpenGuide,
    required this.onOpenSaved,
    required this.onApply,
  });

  final VoidCallback onPostCircular;
  final VoidCallback onOpenGuide;
  final VoidCallback onOpenSaved;
  final ValueChanged<Job> onApply;
}
