import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/pass_reset_repo.dart';

class PasswordResetState {
  const PasswordResetState({this.isLoading = false, this.error});

  final bool isLoading;
  final String? error;
}

class PasswordResetController extends Notifier<PasswordResetState> {
  @override
  PasswordResetState build() => const PasswordResetState();

  PasswordResetRepository get _repo =>
      ref.read(passwordResetRepositoryProvider);

  void reset() => state = const PasswordResetState();

  /// Step 1: email -> OTP. Returns true on success.
  Future<bool> sendOtp(String email) async {
    final r = await _run(() async {
      await _repo.sendOtp(email.trim());
      return true;
    });
    return r ?? false;
  }

  /// Step 2: OTP -> resetToken. Returns the token, or null on failure.
  Future<String?> verifyOtp({required String email, required String otp}) =>
      _run(() => _repo.verifyOtp(email: email.trim(), otp: otp.trim()));

  /// Step 3: resetToken + newPassword. Returns true on success.
  Future<bool> submitNewPassword({
    required String resetToken,
    required String newPassword,
  }) async {
    final r = await _run(() async {
      await _repo.resetPassword(
        resetToken: resetToken,
        newPassword: newPassword,
      );
      return true;
    });
    return r ?? false;
  }

  Future<T?> _run<T>(Future<T> Function() action) async {
    state = const PasswordResetState(isLoading: true);
    try {
      final result = await action();
      state = const PasswordResetState();
      return result;
    } catch (e) {
      // Map to a friendlier message if your API returns structured errors.
      state = PasswordResetState(error: e.toString());
      return null;
    }
  }
}

final passwordResetControllerProvider =
    NotifierProvider<PasswordResetController, PasswordResetState>(
      PasswordResetController.new,
    );
