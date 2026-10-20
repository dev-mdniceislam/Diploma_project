// ── Session ─────────────────────────────────────────────────────────────────
import 'package:flutter/foundation.dart';

import '../../data/model/login_model.dart';

@immutable
class SessionState {
  const SessionState({
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
  factory SessionState.initial() {
    return const SessionState(
      user: null,
      isLoading: false,
      error: null,
      verifyButton: false,
      isShowOtpField: false,
    );
  }

  /// স্টেট আপডেট করার জন্য copyWith মেথড
  SessionState copyWith({
    UserLoginModel? user,
    bool? isLoading,
    String? error,
    bool? verifyButton,
    bool? isShowOtpField,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return SessionState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      verifyButton: verifyButton ?? this.verifyButton,
      isShowOtpField: isShowOtpField ?? this.isShowOtpField,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SessionState &&
        other.user == user &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.verifyButton == verifyButton &&
        other.isShowOtpField == isShowOtpField;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        isLoading.hashCode ^
        error.hashCode ^
        verifyButton.hashCode ^
        isShowOtpField.hashCode;
  }

  @override
  String toString() {
    return 'SessionState(user: $user, isLoading: $isLoading, error: $error, verifyButton: $verifyButton, isShowOtpField: $isShowOtpField, isAuthenticated: $isAuthenticated)';
  }
}
