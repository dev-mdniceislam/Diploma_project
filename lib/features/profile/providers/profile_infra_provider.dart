import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/gen/network_caller_gen.dart';
import '../data/profile_repository.dart';


final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(networkCallerProvider));
});

// /// Role gate: GET profile -> {id, role, name, email}
// final profileUserProvider = FutureProvider.autoDispose<ProfileUser>((ref) {
//   return ref.watch(profileRepositoryProvider).fetchProfileUser();
// });
