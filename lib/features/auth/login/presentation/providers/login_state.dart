// ── Session ─────────────────────────────────────────────────────────────────
import 'package:flutter/foundation.dart';

@immutable
class LoginState {
  const LoginState({this.isLoading = false, this.error});

  final bool isLoading;
  final String? error;

  factory LoginState.initial() {
    return const LoginState(isLoading: false, error: null);
  }

  LoginState copyWith({
    bool? isLoading,
    String? error,
    bool? verifyButton,
    bool? isShowOtpField,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
