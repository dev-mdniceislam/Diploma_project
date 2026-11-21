import 'package:diploma_job/features/profile/data/model/company_profile_model.dart';
import 'package:flutter/foundation.dart';


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
  final ValueChanged<IndustrialJobModel> onApply;
}
