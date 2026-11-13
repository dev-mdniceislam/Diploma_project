import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/gen/network_caller_gen.dart';
import '../data/profile_models.dart';
import '../data/profile_repository.dart';

final networkCallerProvider = Provider<NetworkCaller>((_) => NetworkCaller());

// TODO: login-এর token আপনার auth storage থেকে পড়ুন
final authTokenProvider = Provider<String?>((_) => null);

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(
    ref.watch(networkCallerProvider),
    ref.watch(authTokenProvider),
  ),
);

/// Role gate: GET profile. Logout-এ `ref.invalidate(profileUserProvider)` করুন।
