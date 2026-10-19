import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/login_model.dart';
import '../../domain/entities/auth_enums.dart'; // shudhu AuthMode thakle, UserRole ekhane theke soriye din
import '../../domain/entities/registration_data.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/mock_auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);

// ── Session ─────────────────────────────────────────────────────────────────
class SessionState {
  const SessionState({this.user, this.isLoading = false, this.error});

  final UserLoginModel? user;
  final bool isLoading;
  final String? error;

  bool get isAuthenticated => user != null;
}

// ========================== main notifier ========================
class SessionNotifier extends Notifier<SessionState> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  SessionState build() => const SessionState();

  Future<bool> login({required String email, required String password}) =>
      _authenticate(() => _repo.login(email: email, password: password));

  Future<bool> register(RegistrationData data) =>
      _authenticate(() => _repo.register(data));

  Future<bool> signInWithGoogle() => _authenticate(_repo.signInWithGoogle);
  Future<bool> sendPasswordReset(String email) =>
      _authenticate(_repo.signInWithGoogle);

  void logout() => state = const SessionState();

  void clearError() {
    if (state.error != null) {
      state = SessionState(user: state.user);
    }
  }

  Future<bool> _authenticate(Future<UserLoginModel?> Function() action) async {
    state = const SessionState(isLoading: true);
    try {
      final user = await action();
      if (user == null) {
        state = const SessionState(error: 'কিছু একটা সমস্যা হয়েছে।');
        return false;
      }
      state = SessionState(user: user);
      return true;
    } catch (e) {
      state = SessionState(error: e.toString());
      return false;
    }
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
