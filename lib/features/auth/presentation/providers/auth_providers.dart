import 'dart:developer';

import 'package:diploma_job/core/widgets/custom_overlay_notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/login_model.dart';
import '../../domain/entities/auth_enums.dart';
import '../../domain/entities/registration_data.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/mock_auth_repository.dart';
import 'auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);

// ========================== main notifier ========================
class SessionNotifier extends Notifier<SessionState> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  SessionState build() => const SessionState();

  Future<bool> login({required String email, required String password}) =>
      _authenticate(() => _repo.login(email: email, password: password));

  Future<void> verifyEmail(String email) async {
    if (state.verifyButton) return;
    state = state.copyWith(verifyButton: true);
    try {
      final status = await _repo.verifyEamil(email: email);
      state = state.copyWith(verifyButton: false, isShowOtpField: status);
    } catch (error) {
      state = state.copyWith(verifyButton: false);
      log("=====Verify email provider ${error.toString()}");
      CustomToast.showError(message: error.toString());
    }
  }

  void resetOtp() => state = state.copyWith(isShowOtpField: false);

  Future<bool> register(RegistrationData data) =>
      _authenticate(() => _repo.register(data));

  Future<bool> signInWithGoogle() => _authenticate(_repo.signInWithGoogle);

  Future<bool> sendPasswordReset(String email) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repo.sendPasswordReset(email);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  void logout() => state = const SessionState();

  Future<bool> _authenticate(Future<UserLoginModel?> Function() action) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await action();
      if (user == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'কিছু একটা সমস্যা হয়েছে।',
        );
        CustomToast.showError(message: state.error.toString());

        return false;
      }
      state = state.copyWith(isLoading: false, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      CustomToast.showError(message: e.toString());
      return false;
    }
  }

  void clearError() {
    if (state.error != null) state = state.copyWith(clearError: true);
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, SessionState>(
  SessionNotifier.new,
);

final currentUserProvider = Provider<UserLoginModel?>(
  (ref) => ref.watch(sessionProvider.select((s) => s.user)),
);

// ── Auth page UI state ──────────────────────────────────────────────────────
class AuthRoleNotifier extends Notifier<UserRole> {
  @override
  UserRole build() => UserRole.student;

  void set(UserRole role) => state = role;
}

final authRoleProvider = NotifierProvider<AuthRoleNotifier, UserRole>(
  AuthRoleNotifier.new,
);

class AuthModeNotifier extends Notifier<AuthMode> {
  @override
  AuthMode build() => AuthMode.login;

  void set(AuthMode mode) => state = mode;
}

final authModeProvider = NotifierProvider<AuthModeNotifier, AuthMode>(
  AuthModeNotifier.new,
);
