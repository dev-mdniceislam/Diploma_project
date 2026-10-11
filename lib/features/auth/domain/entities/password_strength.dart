enum PasswordStrength { empty, weak, medium, strong }

class PasswordStrengthResult {
  const PasswordStrengthResult(this.level, this.score);

  final PasswordStrength level;

  /// 0.0 – 1.0
  final double score;
}

/// Same scoring rules as the HTML prototype.
PasswordStrengthResult evaluatePassword(String password) {
  if (password.isEmpty) {
    return const PasswordStrengthResult(PasswordStrength.empty, 0);
  }

  var score = 0;
  if (password.length >= 8) score += 40;
  if (RegExp(r'[A-Z]').hasMatch(password) || RegExp(r'[0-9]').hasMatch(password)) {
    score += 30;
  }
  if (RegExp(r'[^A-Za-z0-9]').hasMatch(password)) score += 30;

  final level = score <= 40
      ? PasswordStrength.weak
      : score <= 70
          ? PasswordStrength.medium
          : PasswordStrength.strong;

  return PasswordStrengthResult(level, score / 100);
}
