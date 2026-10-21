import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/app_dialog.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/core/widgets/labeled_text_field.dart';
import 'package:diploma_job/core/utils/auth_validators.dart';

import '../providers/password_reset_provider.dart';

class ForgotPasswordDialog extends ConsumerStatefulWidget {
  const ForgotPasswordDialog({super.key, this.initialEmail});

  final String? initialEmail;

  static Future<void> show(BuildContext context, {String? initialEmail}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ForgotPasswordDialog(initialEmail: initialEmail),
    );
  }

  @override
  ConsumerState<ForgotPasswordDialog> createState() =>
      _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends ConsumerState<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  bool _sent = false;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: widget.initialEmail);
    // Clear any stale state from a previous open.
    Future.microtask(
      () => ref.read(passwordResetControllerProvider.notifier).reset(),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await ref
        .read(passwordResetControllerProvider.notifier)
        .sendLink(_email.text);
    if (ok && mounted) setState(() => _sent = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(passwordResetControllerProvider);
    final validators = AuthValidators(l10n);

    return AppDialog(
      title: l10n.resetPasswordTitle,
      maxWidth: 440,
      actions: _sent
          ? [
              CustomButton(
                label: l10n.close,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ]
          : [
              CustomButton(
                label: l10n.cancel,
                variant: CustomButtonVariant.outline,
                onPressed: state.isLoading
                    ? null
                    : () => Navigator.of(context).pop(),
              ),
              CustomButton(
                label: l10n.sendLink,
                isLoading: state.isLoading,
                onPressed: _submit,
              ),
            ],
      child: _sent
          ? _SuccessView(email: _email.text.trim())
          : _form(l10n, state, validators),
    );
  }

  Widget _form(l10n, PasswordResetState state, AuthValidators validators) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(l10n.resetPasswordDesc, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 20),
          LabeledTextField(
            label: '${l10n.emailAddress} *',
            controller: _email,
            hintText: l10n.emailHint,
            preIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            validator: validators.email,
            onSubmitted: (_) => _submit(),
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
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
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
            Icons.mark_email_read_outlined,
            color: AppColors.accentGreenDark,
            size: 28,
          ),
        ),
        const SizedBox(height: 16),
        CustomText(
          l10n.resetLinkSent(email),
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
