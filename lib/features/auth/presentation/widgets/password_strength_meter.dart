import 'package:flutter/material.dart';

import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';

import '../../domain/entities/password_strength.dart';

class PasswordStrengthMeter extends StatelessWidget {
  const PasswordStrengthMeter({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final result = evaluatePassword(password);

    final (color, text) = switch (result.level) {
      PasswordStrength.empty => (AppColors.textMuted, l10n.pwdHintLength),
      PasswordStrength.weak => (AppColors.danger, l10n.pwdWeak),
      PasswordStrength.medium => (AppColors.amber, l10n.pwdMedium),
      PasswordStrength.strong => (AppColors.accentGreen, l10n.pwdStrong),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            height: 6,
            width: double.infinity,
            color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
            child: AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.centerLeft,
              widthFactor: result.score,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        CustomText(
          text,
          style: AppTextStyles.bodySmall
              .copyWith(fontSize: 11.5, color: color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
