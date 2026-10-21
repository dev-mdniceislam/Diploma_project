import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:diploma_job/core/extension/l10n_extension.dart'; // context.l10n
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/app_dialog.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/features/auth/login/widget/password_field.dart';
import 'package:diploma_job/core/utils/auth_validators.dart';

import '../providers/password_reset_provider.dart';

/// Opened when the user lands from the email link:
///   /#/authentication?token=<resetToken>
class ResetPasswordDialog extends ConsumerStatefulWidget {
  const ResetPasswordDialog({super.key, required this.resetToken});

  final String resetToken;

  static Future<bool?> show(
    BuildContext context, {
    required String resetToken,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ResetPasswordDialog(resetToken: resetToken),
    );
  }

  @override
  ConsumerState<ResetPasswordDialog> createState() =>
      _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends ConsumerState<ResetPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _done = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(passwordResetControllerProvider.notifier).reset(),
    );
  }

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await ref
        .read(passwordResetControllerProvider.notifier)
        .submitNewPassword(
          resetToken: widget.resetToken,
          newPassword: _password.text, // sent as {"resetToken", "newPassword"}
        );
    if (ok && mounted) setState(() => _done = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(passwordResetControllerProvider);
    final validators = AuthValidators(l10n);

    return AppDialog(
      title: l10n.setNewPasswordTitle,
      maxWidth: 440,
      actions: _done
          ? [
              CustomButton(
                label: l10n.backToLogin,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ]
          : [
              CustomButton(
                label: l10n.cancel,
                variant: CustomButtonVariant.outline,
                onPressed: state.isLoading
                    ? null
                    : () => Navigator.of(context).pop(false),
              ),
              CustomButton(
                label: l10n.resetPasswordButton,
                isLoading: state.isLoading,
                onPressed: _submit,
              ),
            ],
      child: _done
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: AppColors.accentGreenSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.accentGreenDark,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                CustomText(
                  l10n.passwordResetSuccess,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            )
          : Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    l10n.setNewPasswordDesc,
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    label: '${l10n.newPassword} *',
                    controller: _password,
                    validator: validators.password,
                  ),
                  const SizedBox(height: 16),
                  PasswordField(
                    label: '${l10n.fieldConfirmPassword} *',
                    controller: _confirm,
                    validator: validators.confirmPassword(_password),
                  ),
                  if (state.error != null) ...[
                    const SizedBox(height: 12),
                    CustomText(
                      state.error!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.dangerDark,
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
