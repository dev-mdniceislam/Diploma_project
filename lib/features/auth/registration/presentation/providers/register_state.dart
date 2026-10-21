// ── Session ─────────────────────────────────────────────────────────────────
import 'package:flutter/foundation.dart';

import '../../../login/data/model/login_model.dart';

@immutable
class RegistrationState {
  const RegistrationState({
    this.user,
    this.isLoading = false,
    this.error,
    this.verifyButton = false,
    this.isShowOtpField = false,
  });

  final UserLoginModel? user;
  final bool isLoading;
  final String? error;
  final bool verifyButton;
  final bool isShowOtpField;

  bool get isAuthenticated => user != null;

  /// ইনিশিয়াল বা ডিফল্ট স্টেট
  factory RegistrationState.initial() {
    return const RegistrationState(
      user: null,
      isLoading: false,
      error: null,
      verifyButton: false,
      isShowOtpField: false,
    );
  }

  /// স্টেট আপডেট করার জন্য copyWith মেথড
  RegistrationState copyWith({
    UserLoginModel? user,
    bool? isLoading,
    String? error,
    bool? verifyButton,
    bool? isShowOtpField,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return RegistrationState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      verifyButton: verifyButton ?? this.verifyButton,
      isShowOtpField: isShowOtpField ?? this.isShowOtpField,
    );
  }
}
