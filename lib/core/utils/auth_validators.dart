import 'package:flutter/widgets.dart';

import 'package:diploma_job/core/l10n/app_localizations.dart';

/// Localized form validators.
class AuthValidators {
  const AuthValidators(this.l10n);

  final AppLocalizations l10n;

  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final _otp = RegExp(r'^\d{6}$');

  String? otp(String? value) {
    final empty = notEmpty(value);
    if (empty != null) return empty;
    return _otp.hasMatch(value!.trim()) ? null : l10n.errInvalidOtp;
  }

  String? notEmpty(String? value) =>
      (value == null || value.trim().isEmpty) ? l10n.errRequired : null;

  String? email(String? value) {
    final empty = notEmpty(value);
    if (empty != null) return empty;
    return _email.hasMatch(value!.trim()) ? null : l10n.errInvalidEmail;
  }

  String? password(String? value) {
    final empty = notEmpty(value);
    if (empty != null) return empty;
    return value!.length >= 8 ? null : l10n.errPasswordShort;
  }

  FormFieldValidator<String> confirmPassword(TextEditingController original) {
    return (value) {
      final empty = notEmpty(value);
      if (empty != null) return empty;
      return value == original.text ? null : l10n.errPasswordMismatch;
    };
  }

  String? optionalUrl(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    final uri = Uri.tryParse(text);
    final ok = uri != null && uri.hasScheme && uri.host.isNotEmpty;
    return ok ? null : l10n.errInvalidUrl;
  }
}
