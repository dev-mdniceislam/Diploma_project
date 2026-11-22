import 'dart:developer';

import 'package:diploma_job/core/gen/network_caller_gen.dart';
import 'package:diploma_job/features/splash/data/model/profile_get_me_model.dart';
import 'package:diploma_job/features/splash/data/repo/profile_get_me_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<ProfileGetMeRepository>((ref) {
  return ProfileGetMeRepository(ref.watch(networkCallerProvider));
});

final userProfileProvider =
    AsyncNotifierProvider<UserProfileNotifier, AuthMiddlewareModel?>(
      UserProfileNotifier.new,
    );

class UserProfileNotifier extends AsyncNotifier<AuthMiddlewareModel?> {
  @override
  Future<AuthMiddlewareModel?> build() async {
    ref.keepAlive();
    return _fetch();
  }

  Future<AuthMiddlewareModel?> _fetch() {
    return ref.read(profileRepositoryProvider).fetchMe();
  }

  Future<void> refresh() async {
    try {
      final profile = await _fetch();
      // token invalid হলে null আসবে, তখন logout হবে; নাহলে নতুন data বসবে
      state = AsyncData(profile);
    } catch (e) {
      // network সমস্যা: পুরনো data অক্ষত থাকবে
      log("[profile] refresh failed, keeping old data: $e");
    }
  }

  void clear() {
    state = const AsyncData(null);
  }

  void setProfile(AuthMiddlewareModel profile) {
    state = AsyncData(profile);
  }
}
