import 'package:diploma_job/core/gen/network_caller_gen.dart';
import 'package:diploma_job/core/providers/shared_prefs_provider.dart';
import 'package:diploma_job/features/splash/presentation/provider/user_profile_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(ref.watch(networkCallerProvider)),
);

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>(
  (ref) => AuthLocalDataSource(ref.watch(sharedPreferencesProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(authLocalDataSourceProvider),
  ),
);

enum AuthMode { login, signup }

enum AuthView { form, forgotPassword, success }

@immutable
class AuthUiState {
  const AuthUiState({
    this.mode = AuthMode.login,
    this.role = UserRole.student,
    this.view = AuthView.form,
    this.obscurePassword = true,
    this.keepSignedIn = true,
    this.acceptedTerms = false,
    this.otpSent = false,
    this.isBusy = false,
    this.user,
  });

  final AuthMode mode;
  final UserRole role;
  final AuthView view;
  final bool obscurePassword;
  final bool keepSignedIn;
  final bool acceptedTerms;
  final bool otpSent;
  final bool isBusy;
  final AuthUser? user;

  AuthUiState copyWith({
    AuthMode? mode,
    UserRole? role,
    AuthView? view,
    bool? obscurePassword,
    bool? keepSignedIn,
    bool? acceptedTerms,
    bool? otpSent,
    bool? isBusy,
    AuthUser? user,
  }) => AuthUiState(
    mode: mode ?? this.mode,
    role: role ?? this.role,
    view: view ?? this.view,
    obscurePassword: obscurePassword ?? this.obscurePassword,
    keepSignedIn: keepSignedIn ?? this.keepSignedIn,
    acceptedTerms: acceptedTerms ?? this.acceptedTerms,
    otpSent: otpSent ?? this.otpSent,
    isBusy: isBusy ?? this.isBusy,
    user: user ?? this.user,
  );
}

class AuthNotifier extends Notifier<AuthUiState> {
  @override
  AuthUiState build() => const AuthUiState();

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  // ── UI state ──────────────────────────────────────────────
  void switchMode(AuthMode mode) =>
      state = state.copyWith(mode: mode, otpSent: false);

  void selectRole(UserRole role) => state = state.copyWith(role: role);

  void togglePasswordVisibility() =>
      state = state.copyWith(obscurePassword: !state.obscurePassword);

  void setKeepSignedIn(bool value) =>
      state = state.copyWith(keepSignedIn: value);

  void setAcceptedTerms(bool value) =>
      state = state.copyWith(acceptedTerms: value);

  void showView(AuthView view) => state = state.copyWith(view: view);

  // ── Auth actions ──────────────────────────────────────────

  Future<void> sendOtp(String email) async {
    await _busy(() => _repo.sendOtp(email: email));
    state = state.copyWith(otpSent: true);
  }

  /// Login: token save → profile refresh.
  /// Router redirect (loggedIn && onAuth) nijei home e niye jabe.
  Future<void> login({required String email, required String password}) async {
    final user = await _busy(
      () => _repo.login(
        email: email,
        password: password,
        persist: state.keepSignedIn,
      ),
    );
    state = state.copyWith(user: user);
    await ref.read(userProfileProvider.notifier).refresh();
  }

  /// Register: token save kore success card dekhay.
  /// Router ke ekhon refresh korbo na, nahole card skip hoye jabe.
  Future<void> register({
    required String name,
    required String email,
    required String otp,
    required String password,
  }) async {
    final input = RegisterInput(
      role: state.role,
      name: name,
      email: email,
      otp: otp,
      password: password,
    );
    final user = await _busy(() => _repo.register(input, persist: true));
    state = state.copyWith(user: user, view: AuthView.success);
  }

  /// Success card shesh hole ekhane profile refresh hobe,
  /// router redirect home e niye jabe.
  Future<void> finishRegistration() async {
    await ref.read(userProfileProvider.notifier).refresh();
    if (ref.read(userProfileProvider).value == null) {
      // Profile load hoyni — form e fire jao
      state = state.copyWith(view: AuthView.form);
    }
  }

  // ── Forgot password actions ───────────────────────────────

  Future<void> requestPasswordReset(String email) =>
      _busy(() => _repo.requestPasswordReset(email: email));

  Future<String> verifyResetOtp({required String email, required String otp}) =>
      _busy(() => _repo.verifyResetOtp(email: email, otp: otp));

  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  }) => _busy(
    () => _repo.resetPassword(resetToken: resetToken, newPassword: newPassword),
  );

  // ── Helpers ───────────────────────────────────────────────

  Future<T> _busy<T>(Future<T> Function() action) async {
    state = state.copyWith(isBusy: true);
    try {
      return await action();
    } finally {
      state = state.copyWith(isBusy: false);
    }
  }
}

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthUiState>(
  AuthNotifier.new,
);
