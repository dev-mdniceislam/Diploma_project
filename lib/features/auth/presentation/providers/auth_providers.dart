import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/mock_auth_repository.dart';
import '../../domain/entities/auth_enums.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/entities/registration_data.dart';
import '../../domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => MockAuthRepository(),
);

// ── Session ─────────────────────────────────────────────────────────────────
class SessionState {
  const SessionState({this.user, this.isLoading = false});

  final AuthUser? user;
  final bool isLoading;

  bool get isAuthenticated => user != null;
}

// ========================== main notifier ========================
class SessionNotifier extends Notifier<SessionState> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  SessionState build() => const SessionState();

  Future<bool> login({
    required String email,
    required String password,
    required UserRole role,
  }) => _authenticate(
    () => _repo.login(email: email, password: password, role: role),
  );

  Future<bool> register(RegistrationData data) {
    return _authenticate(() => _repo.register(data));
  }

  Future<bool> signInWithGoogle() => _authenticate(_repo.signInWithGoogle);

  void logout() => state = const SessionState();

  Future<bool> _authenticate(Future<AuthUser> Function() action) async {
    state = const SessionState(isLoading: true);
    try {
      state = SessionState(user: await action());
      return true;
    } catch (_) {
      state = const SessionState();
      return false;
    }
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, SessionState>(
  SessionNotifier.new,
);

final currentUserProvider = Provider<AuthUser?>(
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
