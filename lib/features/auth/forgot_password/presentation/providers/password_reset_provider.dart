import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/pass_reset_repo.dart';

class PasswordResetState {
  const PasswordResetState({this.isLoading = false, this.error});

  final bool isLoading;
  final String? error;

  PasswordResetState copyWith({bool? isLoading, String? error}) =>
      PasswordResetState(isLoading: isLoading ?? this.isLoading, error: error);
}

class PasswordResetController extends Notifier<PasswordResetState> {
  @override
  PasswordResetState build() => const PasswordResetState();

  PasswordResetRepository get _repo =>
      ref.read(passwordResetRepositoryProvider);

  void reset() => state = const PasswordResetState();

  /// Returns true on success.
  Future<bool> sendLink(String email) =>
      _run(() => _repo.sendResetLink(email.trim()));

  /// Returns true on success.
  Future<bool> submitNewPassword({
    required String resetToken,
    required String newPassword,
  }) => _run(
    () => _repo.resetPassword(resetToken: resetToken, newPassword: newPassword),
  );

  Future<bool> _run(Future<void> Function() action) async {
    state = const PasswordResetState(isLoading: true);
    try {
      await action();
      state = const PasswordResetState();
      return true;
    } catch (e) {
      // Map to a friendlier message if your API returns structured errors.
      state = PasswordResetState(error: e.toString());
      return false;
    }
  }
}

final passwordResetControllerProvider =
    NotifierProvider<PasswordResetController, PasswordResetState>(
      PasswordResetController.new,
    );
