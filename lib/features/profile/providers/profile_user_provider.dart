import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/profile_models.dart'; // UserRole
import 'profile_infra_provider.dart';

/// Role gate: null মানে role জানা নেই বা unsupported
final profileUserProvider = FutureProvider.autoDispose<UserRole?>((ref) {
  return ref.watch(profileRepositoryProvider).fetchUserRole();
});
